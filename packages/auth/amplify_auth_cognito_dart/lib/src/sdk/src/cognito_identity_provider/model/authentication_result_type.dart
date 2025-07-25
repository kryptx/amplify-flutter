// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.authentication_result_type; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/new_device_metadata_type.dart';
import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'authentication_result_type.g.dart';

/// The object that your application receives after authentication. Contains tokens and information for device authentication.
abstract class AuthenticationResultType
    with _i1.AWSEquatable<AuthenticationResultType>
    implements
        Built<AuthenticationResultType, AuthenticationResultTypeBuilder> {
  /// The object that your application receives after authentication. Contains tokens and information for device authentication.
  factory AuthenticationResultType({
    String? accessToken,
    int? expiresIn,
    String? tokenType,
    String? refreshToken,
    String? idToken,
    NewDeviceMetadataType? newDeviceMetadata,
  }) {
    expiresIn ??= 0;
    return _$AuthenticationResultType._(
      accessToken: accessToken,
      expiresIn: expiresIn,
      tokenType: tokenType,
      refreshToken: refreshToken,
      idToken: idToken,
      newDeviceMetadata: newDeviceMetadata,
    );
  }

  /// The object that your application receives after authentication. Contains tokens and information for device authentication.
  factory AuthenticationResultType.build([
    void Function(AuthenticationResultTypeBuilder) updates,
  ]) = _$AuthenticationResultType;

  const AuthenticationResultType._();

  static const List<_i2.SmithySerializer<AuthenticationResultType>>
  serializers = [AuthenticationResultTypeAwsJson11Serializer()];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(AuthenticationResultTypeBuilder b) {
    b..expiresIn = 0;
  }

  /// Your user's access token.
  String? get accessToken;

  /// The expiration period of the authentication result in seconds.
  int get expiresIn;

  /// The intended use of the token, for example `Bearer`.
  String? get tokenType;

  /// Your user's refresh token.
  String? get refreshToken;

  /// Your user's ID token.
  String? get idToken;

  /// The new device metadata from an authentication result.
  NewDeviceMetadataType? get newDeviceMetadata;
  @override
  List<Object?> get props => [
    accessToken,
    expiresIn,
    tokenType,
    refreshToken,
    idToken,
    newDeviceMetadata,
  ];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('AuthenticationResultType')
      ..add('accessToken', '***SENSITIVE***')
      ..add('expiresIn', expiresIn)
      ..add('tokenType', tokenType)
      ..add('refreshToken', '***SENSITIVE***')
      ..add('idToken', '***SENSITIVE***')
      ..add('newDeviceMetadata', newDeviceMetadata);
    return helper.toString();
  }
}

class AuthenticationResultTypeAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<AuthenticationResultType> {
  const AuthenticationResultTypeAwsJson11Serializer()
    : super('AuthenticationResultType');

  @override
  Iterable<Type> get types => const [
    AuthenticationResultType,
    _$AuthenticationResultType,
  ];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  AuthenticationResultType deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthenticationResultTypeBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'AccessToken':
          result.accessToken =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'ExpiresIn':
          result.expiresIn =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )
                  as int);
        case 'TokenType':
          result.tokenType =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'RefreshToken':
          result.refreshToken =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'IdToken':
          result.idToken =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'NewDeviceMetadata':
          result.newDeviceMetadata.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(NewDeviceMetadataType),
                )
                as NewDeviceMetadataType),
          );
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AuthenticationResultType object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final AuthenticationResultType(
      :accessToken,
      :expiresIn,
      :tokenType,
      :refreshToken,
      :idToken,
      :newDeviceMetadata,
    ) = object;
    result$.addAll([
      'ExpiresIn',
      serializers.serialize(expiresIn, specifiedType: const FullType(int)),
    ]);
    if (accessToken != null) {
      result$
        ..add('AccessToken')
        ..add(
          serializers.serialize(
            accessToken,
            specifiedType: const FullType(String),
          ),
        );
    }
    if (tokenType != null) {
      result$
        ..add('TokenType')
        ..add(
          serializers.serialize(
            tokenType,
            specifiedType: const FullType(String),
          ),
        );
    }
    if (refreshToken != null) {
      result$
        ..add('RefreshToken')
        ..add(
          serializers.serialize(
            refreshToken,
            specifiedType: const FullType(String),
          ),
        );
    }
    if (idToken != null) {
      result$
        ..add('IdToken')
        ..add(
          serializers.serialize(idToken, specifiedType: const FullType(String)),
        );
    }
    if (newDeviceMetadata != null) {
      result$
        ..add('NewDeviceMetadata')
        ..add(
          serializers.serialize(
            newDeviceMetadata,
            specifiedType: const FullType(NewDeviceMetadataType),
          ),
        );
    }
    return result$;
  }
}
