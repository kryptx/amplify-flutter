// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.invalid_sms_role_access_policy_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'invalid_sms_role_access_policy_exception.g.dart';

/// This exception is returned when the role provided for SMS configuration doesn't have permission to publish using Amazon SNS.
abstract class InvalidSmsRoleAccessPolicyException
    with _i1.AWSEquatable<InvalidSmsRoleAccessPolicyException>
    implements
        Built<
          InvalidSmsRoleAccessPolicyException,
          InvalidSmsRoleAccessPolicyExceptionBuilder
        >,
        _i2.SmithyHttpException {
  /// This exception is returned when the role provided for SMS configuration doesn't have permission to publish using Amazon SNS.
  factory InvalidSmsRoleAccessPolicyException({String? message}) {
    return _$InvalidSmsRoleAccessPolicyException._(message: message);
  }

  /// This exception is returned when the role provided for SMS configuration doesn't have permission to publish using Amazon SNS.
  factory InvalidSmsRoleAccessPolicyException.build([
    void Function(InvalidSmsRoleAccessPolicyExceptionBuilder) updates,
  ]) = _$InvalidSmsRoleAccessPolicyException;

  const InvalidSmsRoleAccessPolicyException._();

  /// Constructs a [InvalidSmsRoleAccessPolicyException] from a [payload] and [response].
  factory InvalidSmsRoleAccessPolicyException.fromResponse(
    InvalidSmsRoleAccessPolicyException payload,
    _i1.AWSBaseHttpResponse response,
  ) => payload.rebuild((b) {
    b.headers = response.headers;
  });

  static const List<_i2.SmithySerializer<InvalidSmsRoleAccessPolicyException>>
  serializers = [InvalidSmsRoleAccessPolicyExceptionAwsJson11Serializer()];

  /// The message returned when the invalid SMS role access policy exception is thrown.
  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
    namespace: 'com.amazonaws.cognitoidentityprovider',
    shape: 'InvalidSmsRoleAccessPolicyException',
  );

  @override
  _i2.RetryConfig? get retryConfig => null;

  @override
  @BuiltValueField(compare: false)
  int get statusCode => 400;

  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper(
      'InvalidSmsRoleAccessPolicyException',
    )..add('message', message);
    return helper.toString();
  }
}

class InvalidSmsRoleAccessPolicyExceptionAwsJson11Serializer
    extends
        _i2.StructuredSmithySerializer<InvalidSmsRoleAccessPolicyException> {
  const InvalidSmsRoleAccessPolicyExceptionAwsJson11Serializer()
    : super('InvalidSmsRoleAccessPolicyException');

  @override
  Iterable<Type> get types => const [
    InvalidSmsRoleAccessPolicyException,
    _$InvalidSmsRoleAccessPolicyException,
  ];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  InvalidSmsRoleAccessPolicyException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvalidSmsRoleAccessPolicyExceptionBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'message':
          result.message =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    InvalidSmsRoleAccessPolicyException object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final InvalidSmsRoleAccessPolicyException(:message) = object;
    if (message != null) {
      result$
        ..add('message')
        ..add(
          serializers.serialize(message, specifiedType: const FullType(String)),
        );
    }
    return result$;
  }
}
