// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.sign_up_request; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/analytics_metadata_type.dart';
import 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/attribute_type.dart';
import 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/user_context_data_type.dart';
import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_collection/built_collection.dart' as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i1;

part 'sign_up_request.g.dart';

/// Represents the request to register a user.
abstract class SignUpRequest
    with _i1.HttpInput<SignUpRequest>, _i2.AWSEquatable<SignUpRequest>
    implements Built<SignUpRequest, SignUpRequestBuilder> {
  /// Represents the request to register a user.
  factory SignUpRequest({
    required String clientId,
    String? secretHash,
    required String username,
    String? password,
    List<AttributeType>? userAttributes,
    List<AttributeType>? validationData,
    AnalyticsMetadataType? analyticsMetadata,
    UserContextDataType? userContextData,
    Map<String, String>? clientMetadata,
  }) {
    return _$SignUpRequest._(
      clientId: clientId,
      secretHash: secretHash,
      username: username,
      password: password,
      userAttributes: userAttributes == null
          ? null
          : _i3.BuiltList(userAttributes),
      validationData: validationData == null
          ? null
          : _i3.BuiltList(validationData),
      analyticsMetadata: analyticsMetadata,
      userContextData: userContextData,
      clientMetadata: clientMetadata == null
          ? null
          : _i3.BuiltMap(clientMetadata),
    );
  }

  /// Represents the request to register a user.
  factory SignUpRequest.build([void Function(SignUpRequestBuilder) updates]) =
      _$SignUpRequest;

  const SignUpRequest._();

  factory SignUpRequest.fromRequest(
    SignUpRequest payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) => payload;

  static const List<_i1.SmithySerializer<SignUpRequest>> serializers = [
    SignUpRequestAwsJson11Serializer(),
  ];

  /// The ID of the app client where the user wants to sign up.
  String get clientId;

  /// A keyed-hash message authentication code (HMAC) calculated using the secret key of a user pool client and username plus the client ID in the message. For more information about `SecretHash`, see [Computing secret hash values](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#cognito-user-pools-computing-secret-hash).
  String? get secretHash;

  /// The username of the user that you want to sign up. The value of this parameter is typically a username, but can be any alias attribute in your user pool.
  String get username;

  /// The user's proposed password. The password must comply with the [password requirements](https://docs.aws.amazon.com/cognito/latest/developerguide/managing-users-passwords.html) of your user pool.
  ///
  /// Users can sign up without a password when your user pool supports passwordless sign-in with email or SMS OTPs. To create a user with no password, omit this parameter or submit a blank value. You can only create a passwordless user when passwordless sign-in is available.
  String? get password;

  /// An array of name-value pairs representing user attributes.
  ///
  /// For custom attributes, include a `custom:` prefix in the attribute name, for example `custom:department`.
  _i3.BuiltList<AttributeType>? get userAttributes;

  /// Temporary user attributes that contribute to the outcomes of your pre sign-up Lambda trigger. This set of key-value pairs are for custom validation of information that you collect from your users but don't need to retain.
  ///
  /// Your Lambda function can analyze this additional data and act on it. Your function can automatically confirm and verify select users or perform external API operations like logging user attributes and validation data to Amazon CloudWatch Logs.
  ///
  /// For more information about the pre sign-up Lambda trigger, see [Pre sign-up Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html).
  _i3.BuiltList<AttributeType>? get validationData;

  /// Information that supports analytics outcomes with Amazon Pinpoint, including the user's endpoint ID. The endpoint ID is a destination for Amazon Pinpoint push notifications, for example a device identifier, email address, or phone number.
  AnalyticsMetadataType? get analyticsMetadata;

  /// Contextual data about your user session like the device fingerprint, IP address, or location. Amazon Cognito threat protection evaluates the risk of an authentication event based on the context that your app generates and passes to Amazon Cognito when it makes API requests.
  ///
  /// For more information, see [Collecting data for threat protection in applications](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-viewing-threat-protection-app.html).
  UserContextDataType? get userContextData;

  /// A map of custom key-value pairs that you can provide as input for any custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool triggers. When you use the SignUp API action, Amazon Cognito invokes any functions that are assigned to the following triggers: _pre sign-up_, _custom message_, and _post confirmation_. When Amazon Cognito invokes any of these functions, it passes a JSON payload, which the function receives as input. This payload contains a `clientMetadata` attribute, which provides the data that you assigned to the ClientMetadata parameter in your SignUp request. In your function code in Lambda, you can process the `clientMetadata` value to enhance your workflow for your specific needs.
  ///
  /// For more information, see [Using Lambda triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) in the _Amazon Cognito Developer Guide_.
  ///
  /// When you use the `ClientMetadata` parameter, note that Amazon Cognito won't do the following:
  ///
  /// *   Store the `ClientMetadata` value. This data is available only to Lambda triggers that are assigned to a user pool to support custom workflows. If your user pool configuration doesn't include triggers, the `ClientMetadata` parameter serves no purpose.
  ///
  /// *   Validate the `ClientMetadata` value.
  ///
  /// *   Encrypt the `ClientMetadata` value. Don't send sensitive information in this parameter.
  _i3.BuiltMap<String, String>? get clientMetadata;
  @override
  SignUpRequest getPayload() => this;

  @override
  List<Object?> get props => [
    clientId,
    secretHash,
    username,
    password,
    userAttributes,
    validationData,
    analyticsMetadata,
    userContextData,
    clientMetadata,
  ];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('SignUpRequest')
      ..add('clientId', '***SENSITIVE***')
      ..add('secretHash', '***SENSITIVE***')
      ..add('username', '***SENSITIVE***')
      ..add('password', '***SENSITIVE***')
      ..add('userAttributes', userAttributes)
      ..add('validationData', validationData)
      ..add('analyticsMetadata', analyticsMetadata)
      ..add('userContextData', '***SENSITIVE***')
      ..add('clientMetadata', clientMetadata);
    return helper.toString();
  }
}

class SignUpRequestAwsJson11Serializer
    extends _i1.StructuredSmithySerializer<SignUpRequest> {
  const SignUpRequestAwsJson11Serializer() : super('SignUpRequest');

  @override
  Iterable<Type> get types => const [SignUpRequest, _$SignUpRequest];

  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
    _i1.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  SignUpRequest deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignUpRequestBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'ClientId':
          result.clientId =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'SecretHash':
          result.secretHash =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'Username':
          result.username =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'Password':
          result.password =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String);
        case 'UserAttributes':
          result.userAttributes.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.BuiltList, [
                    FullType(AttributeType),
                  ]),
                )
                as _i3.BuiltList<AttributeType>),
          );
        case 'ValidationData':
          result.validationData.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.BuiltList, [
                    FullType(AttributeType),
                  ]),
                )
                as _i3.BuiltList<AttributeType>),
          );
        case 'AnalyticsMetadata':
          result.analyticsMetadata.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(AnalyticsMetadataType),
                )
                as AnalyticsMetadataType),
          );
        case 'UserContextData':
          result.userContextData.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(UserContextDataType),
                )
                as UserContextDataType),
          );
        case 'ClientMetadata':
          result.clientMetadata.replace(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.BuiltMap, [
                    FullType(String),
                    FullType(String),
                  ]),
                )
                as _i3.BuiltMap<String, String>),
          );
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SignUpRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final SignUpRequest(
      :clientId,
      :secretHash,
      :username,
      :password,
      :userAttributes,
      :validationData,
      :analyticsMetadata,
      :userContextData,
      :clientMetadata,
    ) = object;
    result$.addAll([
      'ClientId',
      serializers.serialize(clientId, specifiedType: const FullType(String)),
      'Username',
      serializers.serialize(username, specifiedType: const FullType(String)),
    ]);
    if (secretHash != null) {
      result$
        ..add('SecretHash')
        ..add(
          serializers.serialize(
            secretHash,
            specifiedType: const FullType(String),
          ),
        );
    }
    if (password != null) {
      result$
        ..add('Password')
        ..add(
          serializers.serialize(
            password,
            specifiedType: const FullType(String),
          ),
        );
    }
    if (userAttributes != null) {
      result$
        ..add('UserAttributes')
        ..add(
          serializers.serialize(
            userAttributes,
            specifiedType: const FullType(_i3.BuiltList, [
              FullType(AttributeType),
            ]),
          ),
        );
    }
    if (validationData != null) {
      result$
        ..add('ValidationData')
        ..add(
          serializers.serialize(
            validationData,
            specifiedType: const FullType(_i3.BuiltList, [
              FullType(AttributeType),
            ]),
          ),
        );
    }
    if (analyticsMetadata != null) {
      result$
        ..add('AnalyticsMetadata')
        ..add(
          serializers.serialize(
            analyticsMetadata,
            specifiedType: const FullType(AnalyticsMetadataType),
          ),
        );
    }
    if (userContextData != null) {
      result$
        ..add('UserContextData')
        ..add(
          serializers.serialize(
            userContextData,
            specifiedType: const FullType(UserContextDataType),
          ),
        );
    }
    if (clientMetadata != null) {
      result$
        ..add('ClientMetadata')
        ..add(
          serializers.serialize(
            clientMetadata,
            specifiedType: const FullType(_i3.BuiltMap, [
              FullType(String),
              FullType(String),
            ]),
          ),
        );
    }
    return result$;
  }
}
