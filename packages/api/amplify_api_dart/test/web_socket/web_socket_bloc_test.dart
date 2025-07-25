// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'dart:async';
import 'dart:convert';

import 'package:amplify_api_dart/src/graphql/web_socket/blocs/web_socket_bloc.dart';
import 'package:amplify_api_dart/src/graphql/web_socket/state/web_socket_state.dart';
import 'package:amplify_api_dart/src/graphql/web_socket/types/connectivity_platform.dart';
import 'package:amplify_api_dart/src/graphql/web_socket/types/process_life_cycle.dart';
import 'package:amplify_api_dart/src/graphql/web_socket/types/web_socket_types.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:test/test.dart';

import '../util.dart';

const mockConnectionAck = ConnectionAckMessageEvent(
  ConnectionAckMessagePayload(300000),
);

void main() {
  late WebSocketBloc? bloc;
  late MockWebSocketService? service;

  late MockPollClient mockPollClient;

  const graphQLDocument = '''subscription MySubscription {
    onCreateBlog {
      id
      name
      createdAt
    }
  }''';
  final subscriptionRequest = GraphQLRequest<String>(document: graphQLDocument);

  final mockSubscriptionData = {
    'onCreateBlog': {
      'id': '<blog id>',
      'name': 'Unit Test Blog',
      'createdAt': '2022-09-12T18:03:36.230Z',
    },
  };

  final mockDataString = jsonEncode({
    'id': subscriptionRequest.id,
    'type': 'data',
    'payload': {'data': mockSubscriptionData},
  });

  const subscriptionOptions = GraphQLSubscriptionOptions(
    pollInterval: Duration(seconds: 1),
  );

  WebSocketBloc getWebSocketBloc({bool noConnectivity = false}) {
    if (!noConnectivity) {
      mockNetworkStreamController = StreamController<ConnectivityStatus>();
    }
    mockProcessLifeCycleController = StreamController<ProcessStatus>();
    mockPollClient = MockPollClient();
    service = MockWebSocketService();

    bloc = WebSocketBloc(
      config: testApiKeyConfig,
      authProviderRepo: getTestAuthProviderRepo(),
      wsService: service!,
      subscriptionOptions: subscriptionOptions,
      pollClientOverride: mockPollClient.client,
      connectivity: noConnectivity
          ? const ConnectivityPlatform()
          : const MockConnectivity(),
      processLifeCycle: const MockProcessLifeCycle(),
    );

    sendMockConnectionAck(bloc!, service!);
    sendMockStartAck(bloc!, service!, [subscriptionRequest.id]);

    return bloc!;
  }

  group('WebSocketBloc', () {
    group('non self closing tests', () {
      tearDown(() async {
        bloc!.add(const ShutdownEvent());
        await bloc!.done.future;
        bloc = null;
        service = null; // service gets closed in  bloc
        if (mockNetworkStreamController.hasListener) {
          await mockNetworkStreamController.close();
        }
      });

      test('should init a connection & call onEstablishCallback', () async {
        final subscribeEvent = SubscribeEvent(
          subscriptionRequest,
          expectAsync0(() {}),
        );

        getWebSocketBloc().subscribe(subscribeEvent);
      });

      test('subscribe() should return a subscription stream', () async {
        final dataCompleter = Completer<String>();
        final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
          service!.channel.sink.add(mockDataString);
        });

        final bloc = getWebSocketBloc();
        bloc
            .subscribe(subscribeEvent)
            .listen(
              expectAsync1((event) {
                expect(event.data, json.encode(mockSubscriptionData));
                dataCompleter.complete(event.data);
              }),
            );

        await dataCompleter.future;
      });

      test(
        'should return a subscription stream with default connectivity (empty stream)',
        () async {
          final dataCompleter = Completer<String>();
          final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
            service!.channel.sink.add(mockDataString);
          });

          final bloc = getWebSocketBloc(noConnectivity: true);
          bloc
              .subscribe(subscribeEvent)
              .listen(
                expectAsync1((event) {
                  expect(event.data, json.encode(mockSubscriptionData));
                  dataCompleter.complete(event.data);
                }),
              );
          await dataCompleter.future;
        },
      );
    });

    test('should reconnect when data turns on/off', () async {
      var dataCompleter = Completer<String>();
      final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
        service!.channel.sink.add(mockDataString);
      });

      final bloc = getWebSocketBloc();

      expect(
        bloc.stream,
        emitsInOrder([
          isA<DisconnectedState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
          isA<ReconnectingState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
        ]),
      );

      bloc
          .subscribe(subscribeEvent)
          .listen(
            expectAsync1((event) {
              expect(event.data, json.encode(mockSubscriptionData));
              dataCompleter.complete(event.data);
            }, count: 2),
          );

      await dataCompleter.future;
      dataCompleter = Completer<String>();

      mockNetworkStreamController
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      service!.channel.sink.add(mockDataString);
      await dataCompleter.future;
    });

    test('should throttle reconnect after repeated wifi toggling', () async {
      final blocReady = Completer<void>();
      final subscribeEvent = SubscribeEvent(
        subscriptionRequest,
        blocReady.complete,
      );

      final bloc = getWebSocketBloc();

      expect(
        bloc.stream,
        emitsInOrder([
          isA<DisconnectedState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
          isA<ReconnectingState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
        ]),
        reason:
            'Bloc should debounce multiple reconnection triggers while reconnecting.',
      );

      bloc.subscribe(subscribeEvent);

      await blocReady.future;

      mockNetworkStreamController
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected)
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected)
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected)
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected)
        ..add(ConnectivityStatus.disconnected)
        ..add(ConnectivityStatus.connected);
    });

    test('should reconnect multiple times after reconnecting', () async {
      final blocReady = Completer<void>();
      final subscribeEvent = SubscribeEvent(
        subscriptionRequest,
        blocReady.complete,
      );

      final bloc = getWebSocketBloc()..subscribe(subscribeEvent);

      await blocReady.future;

      mockNetworkStreamController.add(ConnectivityStatus.disconnected);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockNetworkStreamController.add(ConnectivityStatus.connected);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      mockNetworkStreamController.add(ConnectivityStatus.disconnected);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockNetworkStreamController.add(ConnectivityStatus.connected);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      mockNetworkStreamController.add(ConnectivityStatus.disconnected);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockNetworkStreamController.add(ConnectivityStatus.connected);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));
    });

    test('should reconnect after 13 seconds during retry/back off', () async {
      final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
        service!.channel.sink.add(mockDataString);
      });

      final bloc = getWebSocketBloc()..subscribe(subscribeEvent);

      expect(
        bloc.stream,
        emitsInOrder([
          isA<DisconnectedState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
          isA<ReconnectingState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
        ]),
      );

      mockPollClient.induceTimeout = true;

      await Future<void>.delayed(const Duration(seconds: 13));

      mockPollClient.induceTimeout = false;
    });

    test('should reconnect when process resumes', () async {
      var dataCompleter = Completer<String>();
      final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
        service!.channel.sink.add(mockDataString);
      });

      final bloc = getWebSocketBloc();

      expect(
        bloc.stream,
        emitsInOrder([
          isA<DisconnectedState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
          isA<ReconnectingState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
        ]),
      );

      bloc
          .subscribe(subscribeEvent)
          .listen(
            expectAsync1((event) {
              expect(event.data, json.encode(mockSubscriptionData));
              dataCompleter.complete(event.data);
            }, count: 2),
          );

      await dataCompleter.future;
      dataCompleter = Completer<String>();

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      service!.channel.sink.add(mockDataString);
      await dataCompleter.future;
    });

    test('should throttle reconnect after repeatedly resuming', () async {
      final blocReady = Completer<void>();
      final subscribeEvent = SubscribeEvent(
        subscriptionRequest,
        blocReady.complete,
      );

      final bloc = getWebSocketBloc();

      expect(
        bloc.stream,
        emitsInOrder([
          isA<DisconnectedState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
          isA<ReconnectingState>(),
          isA<ConnectingState>(),
          isA<ConnectedState>(),
        ]),
        reason:
            'Bloc should debounce multiple reconnection triggers while resuming.',
      );

      bloc.subscribe(subscribeEvent);

      await blocReady.future;

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed)
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed)
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed)
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed)
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);
    });

    test('should reconnect multiple times after resuming', () async {
      final blocReady = Completer<void>();
      final subscribeEvent = SubscribeEvent(
        subscriptionRequest,
        blocReady.complete,
      );

      final bloc = getWebSocketBloc()..subscribe(subscribeEvent);

      await blocReady.future;

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ReconnectingState>()));

      mockProcessLifeCycleController
        ..add(ProcessStatus.paused)
        ..add(ProcessStatus.resumed);

      await expectLater(bloc.stream, emitsThrough(isA<ConnectedState>()));
    });

    test(
      'subscribe() ignores a WebSocket message that comes while the bloc is disconnected',
      () async {
        final establishCompleter = Completer<void>();
        final subscribeEvent = SubscribeEvent(
          subscriptionRequest,
          establishCompleter.complete,
        );

        final bloc = getWebSocketBloc();
        bloc.subscribe(subscribeEvent).listen(null);
        await establishCompleter.future;

        bloc.add(const ShutdownEvent());
        await bloc.done.future;

        service!.channel.sink.add(mockDataString);
        await expectLater(service!.channel.sink.done, completes);
      },
    );

    group('should close when', () {
      tearDown(() async {
        bloc = null;
        service = null; // service gets closed in  bloc
      });
      test('triggering FailureState on Exception during init', () async {
        final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
          service!.channel.sink.add(mockDataString);
        });

        final badService = MockWebSocketService(badInit: true);
        mockNetworkStreamController = StreamController<ConnectivityStatus>();
        mockProcessLifeCycleController = StreamController<ProcessStatus>();
        final bloc = WebSocketBloc(
          config: testApiKeyConfig,
          authProviderRepo: getTestAuthProviderRepo(),
          wsService: badService,
          subscriptionOptions: subscriptionOptions,
          pollClientOverride: mockPollClient.client,
          connectivity: const MockConnectivity(),
          processLifeCycle: const MockProcessLifeCycle(),
        );

        expect(
          bloc.stream,
          emitsInOrder([
            isA<DisconnectedState>(),
            isA<ConnectingState>(),
            isA<FailureState>(),
            isA<PendingDisconnect>(),
            isA<DisconnectedState>(),
          ]),
        );

        bloc.subscribe(subscribeEvent);
        // TODO(equartey): Fix this test on web
      }, skip: zIsWeb);

      test('Exception from service and should return error to user', () async {
        final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
          service!.channel.sink.addError(Exception('unknown exception'));
        });
        final bloc = getWebSocketBloc();

        expect(
          bloc.stream,
          emitsInOrder([
            isA<DisconnectedState>(),
            isA<ConnectingState>(),
            isA<ConnectedState>(),
            isA<FailureState>(),
            isA<PendingDisconnect>(),
            isA<DisconnectedState>(),
          ]),
        );

        final subscription = bloc.subscribe(subscribeEvent);
        expect(subscription, emitsError(isA<ApiException>()));
      });

      test('an exception when poll responds unhealthy', () async {
        final blocReady = Completer<void>();
        final subscribeEvent = SubscribeEvent(
          subscriptionRequest,
          blocReady.complete,
        );
        final bloc = getWebSocketBloc();

        expect(
          bloc.stream,
          emitsInOrder([
            isA<DisconnectedState>(),
            isA<ConnectingState>(),
            isA<ConnectedState>(),
            isA<ReconnectingState>(),
            isA<FailureState>(),
            isA<PendingDisconnect>(),
            isA<DisconnectedState>(),
          ]),
        );

        bloc
            .subscribe(subscribeEvent)
            .listen(
              null,
              onError: expectAsync1((event) {
                expect(event, isA<ApiException>());
              }),
            );

        await blocReady.future;
        mockPollClient.sendUnhealthyResponse = true;
      });

      test('cancel() sends a stop message', () async {
        final subscribeEvent = SubscribeEvent(subscriptionRequest, () {
          service!.channel.sink.add(mockDataString);
        });

        final dataCompleter = Completer<String>();
        final bloc = getWebSocketBloc();
        final subscription = bloc.subscribe(subscribeEvent);

        final streamSub = subscription.listen(
          (event) => dataCompleter.complete(event.data),
        );

        await dataCompleter.future;

        expect(
          service!.channel.stream,
          emitsInOrder([
            isA<String>().having(
              (event) => json.decode(event),
              'web socket stop message',
              containsPair('type', 'stop'),
            ),
            isA<String>().having(
              (event) => json.decode(event),
              'web socket complete message',
              containsPair('type', 'complete'),
            ),
          ]),
        );
        // bloc should disconnect due to no active subscriptions
        expect(bloc.stream, emitsThrough(isA<DisconnectedState>()));

        await streamSub.cancel();

        await bloc.done.future;
      });

      test('a process resumes with autoReconnect disabled', () async {
        final blocReady = Completer<void>();
        final subscribeEvent = SubscribeEvent(
          subscriptionRequest,
          blocReady.complete,
        );
        final bloc = getWebSocketBloc();

        expect(
          bloc.stream,
          emitsInOrder([
            isA<DisconnectedState>(),
            isA<ConnectingState>(),
            isA<ConnectedState>(),
            isA<FailureState>(),
            isA<PendingDisconnect>(),
            isA<DisconnectedState>(),
          ]),
        );

        // ignore: invalid_use_of_internal_member
        WebSocketOptions.autoReconnect = false;

        bloc
            .subscribe(subscribeEvent)
            .listen(
              null,
              onError: expectAsync1((event) {
                expect(event, isA<ApiException>());
              }),
            );

        await blocReady.future;

        mockProcessLifeCycleController
          ..add(ProcessStatus.paused)
          ..add(ProcessStatus.resumed);
      });
    });
  });
}
