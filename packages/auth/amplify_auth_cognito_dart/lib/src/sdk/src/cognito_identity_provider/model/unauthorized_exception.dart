// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.unauthorized_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'unauthorized_exception.g.dart';

/// Exception that is thrown when the request isn't authorized. This can happen due to an invalid access token in the request.
abstract class UnauthorizedException
    with _i1.AWSEquatable<UnauthorizedException>
    implements
        Built<UnauthorizedException, UnauthorizedExceptionBuilder>,
        _i2.SmithyHttpException {
  /// Exception that is thrown when the request isn't authorized. This can happen due to an invalid access token in the request.
  factory UnauthorizedException({String? message}) {
    return _$UnauthorizedException._(message: message);
  }

  /// Exception that is thrown when the request isn't authorized. This can happen due to an invalid access token in the request.
  factory UnauthorizedException.build([
    void Function(UnauthorizedExceptionBuilder) updates,
  ]) = _$UnauthorizedException;

  const UnauthorizedException._();

  /// Constructs a [UnauthorizedException] from a [payload] and [response].
  factory UnauthorizedException.fromResponse(
    UnauthorizedException payload,
    _i1.AWSBaseHttpResponse response,
  ) => payload.rebuild((b) {
    b.headers = response.headers;
  });

  static const List<_i2.SmithySerializer<UnauthorizedException>> serializers = [
    UnauthorizedExceptionAwsJson11Serializer(),
  ];

  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
    namespace: 'com.amazonaws.cognitoidentityprovider',
    shape: 'UnauthorizedException',
  );

  @override
  _i2.RetryConfig? get retryConfig => null;

  @override
  @BuiltValueField(compare: false)
  int get statusCode => 401;

  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('UnauthorizedException')
      ..add('message', message);
    return helper.toString();
  }
}

class UnauthorizedExceptionAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<UnauthorizedException> {
  const UnauthorizedExceptionAwsJson11Serializer()
    : super('UnauthorizedException');

  @override
  Iterable<Type> get types => const [
    UnauthorizedException,
    _$UnauthorizedException,
  ];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  UnauthorizedException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnauthorizedExceptionBuilder();
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
    UnauthorizedException object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final UnauthorizedException(:message) = object;
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
