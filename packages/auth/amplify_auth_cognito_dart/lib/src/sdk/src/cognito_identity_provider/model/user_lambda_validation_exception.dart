// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.user_lambda_validation_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'user_lambda_validation_exception.g.dart';

/// This exception is thrown when the Amazon Cognito service encounters a user validation exception with the Lambda service.
abstract class UserLambdaValidationException
    with _i1.AWSEquatable<UserLambdaValidationException>
    implements
        Built<
          UserLambdaValidationException,
          UserLambdaValidationExceptionBuilder
        >,
        _i2.SmithyHttpException {
  /// This exception is thrown when the Amazon Cognito service encounters a user validation exception with the Lambda service.
  factory UserLambdaValidationException({String? message}) {
    return _$UserLambdaValidationException._(message: message);
  }

  /// This exception is thrown when the Amazon Cognito service encounters a user validation exception with the Lambda service.
  factory UserLambdaValidationException.build([
    void Function(UserLambdaValidationExceptionBuilder) updates,
  ]) = _$UserLambdaValidationException;

  const UserLambdaValidationException._();

  /// Constructs a [UserLambdaValidationException] from a [payload] and [response].
  factory UserLambdaValidationException.fromResponse(
    UserLambdaValidationException payload,
    _i1.AWSBaseHttpResponse response,
  ) => payload.rebuild((b) {
    b.headers = response.headers;
  });

  static const List<_i2.SmithySerializer<UserLambdaValidationException>>
  serializers = [UserLambdaValidationExceptionAwsJson11Serializer()];

  /// The message returned when the Amazon Cognito service returns a user validation exception with the Lambda service.
  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
    namespace: 'com.amazonaws.cognitoidentityprovider',
    shape: 'UserLambdaValidationException',
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
    final helper = newBuiltValueToStringHelper('UserLambdaValidationException')
      ..add('message', message);
    return helper.toString();
  }
}

class UserLambdaValidationExceptionAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<UserLambdaValidationException> {
  const UserLambdaValidationExceptionAwsJson11Serializer()
    : super('UserLambdaValidationException');

  @override
  Iterable<Type> get types => const [
    UserLambdaValidationException,
    _$UserLambdaValidationException,
  ];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  UserLambdaValidationException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserLambdaValidationExceptionBuilder();
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
    UserLambdaValidationException object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final UserLambdaValidationException(:message) = object;
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
