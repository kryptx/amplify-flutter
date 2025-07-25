// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_secure_storage_dart/amplify_secure_storage_dart.dart';
import 'package:amplify_secure_storage_dart/src/worker/secure_storage_action.dart';
import 'package:aws_common/aws_common.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'secure_storage_request.g.dart';

/// {@template amplify_secure_storage_dart.secure_storage_request}
/// A serializable form of a request to a secure storage instance, combining
/// a [SecureStorageAction] and accompanying data.
/// {@endtemplate}
abstract class SecureStorageRequest
    implements Built<SecureStorageRequest, SecureStorageRequestBuilder> {
  /// {@macro amplify_secure_storage_dart.secure_storage_request}
  factory SecureStorageRequest([
    void Function(SecureStorageRequestBuilder) updates,
  ]) = _$SecureStorageRequest;
  SecureStorageRequest._();

  /// {@macro amplify_secure_storage_dart.secure_storage_interface.init}
  factory SecureStorageRequest.init({
    required AmplifySecureStorageConfig config,
  }) {
    return SecureStorageRequest(
      (b) => b
        ..action = SecureStorageAction.init
        ..config.replace(config),
    );
  }

  /// {@macro amplify_secure_storage_dart.secure_storage_interface.read}
  factory SecureStorageRequest.read({required String key}) {
    return SecureStorageRequest(
      (b) => b
        ..action = SecureStorageAction.read
        ..key = key,
    );
  }

  /// {@macro amplify_secure_storage_dart.secure_storage_interface.write}
  factory SecureStorageRequest.write({
    required String key,
    required String value,
  }) {
    return SecureStorageRequest(
      (b) => b
        ..action = SecureStorageAction.write
        ..key = key
        ..value = value,
    );
  }

  /// {@macro amplify_secure_storage_dart.secure_storage_interface.delete}
  factory SecureStorageRequest.delete({required String key}) {
    return SecureStorageRequest(
      (b) => b
        ..action = SecureStorageAction.delete
        ..key = key,
    );
  }

  /// {@macro amplify_secure_storage_dart.amplify_secure_storage_interface.remove_all}
  factory SecureStorageRequest.removeAll() {
    return SecureStorageRequest(
      (b) => b..action = SecureStorageAction.removeAll,
    );
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _init(SecureStorageRequestBuilder b) {
    b.id ??= uuid();
  }

  /// Unique ID for the request, typically a UUID.
  String get id;

  /// The action to take against the remote secure storage instance.
  SecureStorageAction get action;

  /// The secure storage configuration, used to instantiate a remote secure
  /// storage instance.
  ///
  /// Valid only for [SecureStorageAction.init].
  AmplifySecureStorageConfig? get config;

  /// The key targeted by [action].
  String? get key;

  /// The value associated with [key].
  String? get value;

  /// The [SecureStorageRequest] serializer.
  static Serializer<SecureStorageRequest> get serializer =>
      _$secureStorageRequestSerializer;

  /// toString override that excludes the value.
  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SecureStorageRequest')
          ..add('id', id)
          ..add('action', action)
          ..add('config', config)
          ..add('key', key))
        .toString();
  }
}
