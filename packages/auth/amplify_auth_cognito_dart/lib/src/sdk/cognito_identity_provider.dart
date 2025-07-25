// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

/// # Amazon Cognito Identity Provider
///
/// With the Amazon Cognito user pools API, you can configure user pools and authenticate users. To authenticate users from third-party identity providers (IdPs) in this API, you can [link IdP users to native user profiles](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation-consolidate-users.html). Learn more about the authentication and authorization of federated users at [Adding user pool sign-in through a third party](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html) and in the [User pool federation endpoints and managed login reference](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-userpools-server-contract-reference.html).
///
/// This API reference provides detailed information about API operations and object types in Amazon Cognito.
///
/// Along with resource management operations, the Amazon Cognito user pools API includes classes of operations and authorization models for client-side and server-side authentication of users. You can interact with operations in the Amazon Cognito user pools API as any of the following subjects.
///
/// 1.  An administrator who wants to configure user pools, app clients, users, groups, or other user pool functions.
///
/// 2.  A server-side app, like a web application, that wants to use its Amazon Web Services privileges to manage, authenticate, or authorize a user.
///
/// 3.  A client-side app, like a mobile app, that wants to make unauthenticated requests to manage, authenticate, or authorize a user.
///
///
/// For more information, see [Understanding API, OIDC, and managed login pages authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flows-public-server-side.html#user-pools-API-operations) in the _Amazon Cognito Developer Guide_.
///
/// With your Amazon Web Services SDK, you can build the logic to support operational flows in every use case for this API. You can also make direct REST API requests to [Amazon Cognito user pools service endpoints](https://docs.aws.amazon.com/general/latest/gr/cognito_identity.html#cognito_identity_your_user_pools_region). The following links can get you started with the `CognitoIdentityProvider` client in supported Amazon Web Services SDKs.
///
/// To get started with an Amazon Web Services SDK, see [Tools to Build on Amazon Web Services](http://aws.amazon.com/developer/tools/). For example actions and scenarios, see [Code examples for Amazon Cognito Identity Provider using Amazon Web Services SDKs](https://docs.aws.amazon.com/cognito/latest/developerguide/service_code_examples_cognito-identity-provider.html).
library amplify_auth_cognito_dart.cognito_identity_provider;

export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/cognito_identity_provider_client.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/alias_exists_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/analytics_metadata_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/associate_software_token_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/associate_software_token_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/attribute_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/auth_flow_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/authentication_result_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/challenge_name_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/change_password_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/change_password_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/code_delivery_details_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/code_delivery_failure_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/code_mismatch_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/concurrent_modification_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_device_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_device_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_forgot_password_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_forgot_password_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_sign_up_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/confirm_sign_up_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/delete_user_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/delivery_medium_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/device_key_exists_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/device_remembered_status_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/device_secret_verifier_config_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/device_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/email_mfa_settings_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/enable_software_token_mfa_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/expired_code_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/forbidden_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/forget_device_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/forgot_password_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/forgot_password_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_device_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_device_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_tokens_from_refresh_token_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_tokens_from_refresh_token_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_user_attribute_verification_code_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_user_attribute_verification_code_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_user_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/get_user_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/global_sign_out_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/global_sign_out_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/initiate_auth_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/initiate_auth_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/internal_error_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_email_role_access_policy_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_lambda_response_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_parameter_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_password_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_sms_role_access_policy_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_sms_role_trust_relationship_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/invalid_user_pool_configuration_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/limit_exceeded_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/list_devices_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/list_devices_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/mfa_method_not_found_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/mfa_option_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/new_device_metadata_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/not_authorized_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/password_history_policy_violation_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/password_reset_required_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/refresh_token_reuse_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/resend_confirmation_code_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/resend_confirmation_code_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/resource_not_found_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/respond_to_auth_challenge_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/respond_to_auth_challenge_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/revoke_token_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/revoke_token_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/set_user_mfa_preference_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/set_user_mfa_preference_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/sign_up_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/sign_up_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/sms_mfa_settings_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/software_token_mfa_not_found_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/software_token_mfa_settings_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/too_many_failed_attempts_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/too_many_requests_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/unauthorized_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/unexpected_lambda_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/unsupported_operation_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/unsupported_token_type_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/update_device_status_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/update_device_status_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/update_user_attributes_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/update_user_attributes_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/user_context_data_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/user_lambda_validation_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/user_not_confirmed_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/user_not_found_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/username_exists_exception.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/verify_software_token_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/verify_software_token_response.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/verify_software_token_response_type.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/verify_user_attribute_request.dart';
export 'package:amplify_auth_cognito_dart/src/sdk/src/cognito_identity_provider/model/verify_user_attribute_response.dart';
