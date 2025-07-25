// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'dart:async';
import 'dart:isolate';

import 'package:meta/meta.dart';
import 'package:worker_bee/src/common.dart';
import 'package:worker_bee/src/exception/worker_bee_exception.dart';
import 'package:worker_bee/worker_bee.dart';

/// {@template worker_bee.send_ports}
/// Ports passed to a VM worker bee for relaying messages and exits.
/// {@endtemplate}
class SendPorts {
  /// {@macro worker_bee.send_ports}
  const SendPorts(this.messagePort, this.donePort, this.logPort);

  /// The port used for communicating messages, passed to the [IsolateChannel]
  /// instance upon launch.
  final SendPort messagePort;

  /// The port used for signaling completion from the isolate.
  ///
  /// Passed to [Isolate.exit].
  final SendPort donePort;

  /// The port used for log messages.
  final SendPort logPort;
}

/// The function signature for the generated VM entrypoint, as required by
/// [Isolate.spawn].
typedef VmEntrypoint = Future<void> Function(SendPorts);

/// {@template worker_bee.worker_bee_impl}
/// The platform-specific implementation of [WorkerBeeCommon].
/// {@endtemplate}
@internal
mixin WorkerBeeImpl<Request extends Object, Response>
    on WorkerBeeCommon<Request, Response> {
  @override
  Function /*VmEntrypoint*/ get vmEntrypoint;

  @override
  String? get workerEntrypointOverride {
    return null;
  }

  StreamController<Response>? _controller;
  Isolate? _isolate;

  @override
  Future<void> spawn({String? jsEntrypoint}) async {
    logger.debug('Starting worker');
    final receivePort = ReceivePort(name);

    _controller = StreamController<Response>(sync: true);
    final channel = IsolateChannel<Object?>.connectReceive(receivePort);

    stream = _controller!.stream;
    sink = channel.sink.cast();

    channel.stream.listen((message) {
      logger.verbose('Got message: $message');
      _controller?.add(message as Response);
    });

    final logPort = ReceivePort('${name}_logs');
    final logChannel = IsolateChannel<LogEntry>.connectReceive(logPort);
    logChannel.stream.listen((log) {
      if (logsController.isClosed) return;
      logsController.add(log);
    });

    final donePort = ReceivePort('${name}_done');
    final exitPort = ReceivePort('${name}_exit');
    final errorPort = ReceivePort('${name}_error');
    final ports = SendPorts(
      receivePort.sendPort,
      donePort.sendPort,
      logPort.sendPort,
    );
    _isolate = await Isolate.spawn(
      vmEntrypoint as VmEntrypoint,
      ports,
      debugName: name,
      onExit: exitPort.sendPort,
      onError: errorPort.sendPort,
    );
    unawaited(
      donePort.first.then<void>((dynamic result) {
        if (isCompleted) return;
        if (result is Response?) {
          complete(result);
        } else {
          final error = Exception('Unexpected result: $result');
          _controller?.addError(error);
          completeError(error);
        }
      }),
    );
    unawaited(
      exitPort.first.then<void>((dynamic _) {
        if (isCompleted) return;
        final error = Exception('Worker quit unexpectedly');
        _controller?.addError(error);
        completeError(error);
      }),
    );
    unawaited(
      errorPort.first.then<void>((dynamic error) {
        if (isCompleted) return;
        error as List<Object?>;
        final message = error[0] as String;
        final stackTraceString = error[1] as String?;
        final stackTrace = stackTraceString == null
            ? null
            : StackTrace.fromString(stackTraceString);
        final exception = WorkerBeeExceptionImpl(message, stackTrace);
        _controller?.addError(exception, stackTrace);
        completeError(exception, stackTrace);
      }),
    );
  }

  @override
  Future<void> close({bool force = false}) async {
    await _controller?.close();
    _controller = null;
    await super.close(force: force);
    await logsController.close();
    logger.close();
    _isolate?.kill();
    _isolate = null;
  }
}
