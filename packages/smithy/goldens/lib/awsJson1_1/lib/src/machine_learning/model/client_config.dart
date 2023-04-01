// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library aws_json1_1_v1.machine_learning.model.client_config; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:aws_json1_1_v1/src/machine_learning/model/retry_config.dart'
    as _i3;
import 'package:aws_json1_1_v1/src/machine_learning/model/s3_config.dart'
    as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i4;

part 'client_config.g.dart';

/// Configuration that is set on the constructed client.
abstract class ClientConfig
    with _i1.AWSEquatable<ClientConfig>
    implements Built<ClientConfig, ClientConfigBuilder> {
  /// Configuration that is set on the constructed client.
  factory ClientConfig({
    String? awsAccessKeyId,
    String? awsSecretAccessKey,
    String? awsSessionToken,
    String? region,
    _i2.S3Config? s3,
    _i3.RetryConfig? retryConfig,
    String? awsProfile,
  }) {
    return _$ClientConfig._(
      awsAccessKeyId: awsAccessKeyId,
      awsSecretAccessKey: awsSecretAccessKey,
      awsSessionToken: awsSessionToken,
      region: region,
      s3: s3,
      retryConfig: retryConfig,
      awsProfile: awsProfile,
    );
  }

  /// Configuration that is set on the constructed client.
  factory ClientConfig.build([void Function(ClientConfigBuilder) updates]) =
      _$ClientConfig;

  const ClientConfig._();

  static const List<_i4.SmithySerializer> serializers = [
    ClientConfigAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(ClientConfigBuilder b) {}
  String? get awsAccessKeyId;
  String? get awsSecretAccessKey;
  String? get awsSessionToken;
  String? get region;

  /// Configuration specific to S3.
  _i2.S3Config? get s3;

  /// Configuration specific to retries.
  _i3.RetryConfig? get retryConfig;
  String? get awsProfile;
  @override
  List<Object?> get props => [
        awsAccessKeyId,
        awsSecretAccessKey,
        awsSessionToken,
        region,
        s3,
        retryConfig,
        awsProfile,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('ClientConfig');
    helper.add(
      'awsAccessKeyId',
      awsAccessKeyId,
    );
    helper.add(
      'awsSecretAccessKey',
      awsSecretAccessKey,
    );
    helper.add(
      'awsSessionToken',
      awsSessionToken,
    );
    helper.add(
      'region',
      region,
    );
    helper.add(
      's3',
      s3,
    );
    helper.add(
      'retryConfig',
      retryConfig,
    );
    helper.add(
      'awsProfile',
      awsProfile,
    );
    return helper.toString();
  }
}

class ClientConfigAwsJson11Serializer
    extends _i4.StructuredSmithySerializer<ClientConfig> {
  const ClientConfigAwsJson11Serializer() : super('ClientConfig');

  @override
  Iterable<Type> get types => const [
        ClientConfig,
        _$ClientConfig,
      ];
  @override
  Iterable<_i4.ShapeId> get supportedProtocols => const [
        _i4.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  ClientConfig deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClientConfigBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'aws_access_key_id':
          if (value != null) {
            result.awsAccessKeyId = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 'aws_secret_access_key':
          if (value != null) {
            result.awsSecretAccessKey = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 'aws_session_token':
          if (value != null) {
            result.awsSessionToken = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 'region':
          if (value != null) {
            result.region = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 's3':
          if (value != null) {
            result.s3.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(_i2.S3Config),
            ) as _i2.S3Config));
          }
          break;
        case 'retry_config':
          if (value != null) {
            result.retryConfig.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(_i3.RetryConfig),
            ) as _i3.RetryConfig));
          }
          break;
        case 'aws_profile':
          if (value != null) {
            result.awsProfile = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final payload = (object as ClientConfig);
    final result = <Object?>[];
    if (payload.awsAccessKeyId != null) {
      result
        ..add('aws_access_key_id')
        ..add(serializers.serialize(
          payload.awsAccessKeyId!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.awsSecretAccessKey != null) {
      result
        ..add('aws_secret_access_key')
        ..add(serializers.serialize(
          payload.awsSecretAccessKey!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.awsSessionToken != null) {
      result
        ..add('aws_session_token')
        ..add(serializers.serialize(
          payload.awsSessionToken!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.region != null) {
      result
        ..add('region')
        ..add(serializers.serialize(
          payload.region!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.s3 != null) {
      result
        ..add('s3')
        ..add(serializers.serialize(
          payload.s3!,
          specifiedType: const FullType(_i2.S3Config),
        ));
    }
    if (payload.retryConfig != null) {
      result
        ..add('retry_config')
        ..add(serializers.serialize(
          payload.retryConfig!,
          specifiedType: const FullType(_i3.RetryConfig),
        ));
    }
    if (payload.awsProfile != null) {
      result
        ..add('aws_profile')
        ..add(serializers.serialize(
          payload.awsProfile!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}
