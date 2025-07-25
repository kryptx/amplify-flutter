// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_core/amplify_core.dart';

/// {@macro amplify_core.auth.sign_out_result}
///
/// See also:
/// - [CognitoCompleteSignOut]
/// - [CognitoFailedSignOut]
/// - [CognitoPartialSignOut]
sealed class CognitoSignOutResult extends SignOutResult
    with AWSEquatable<CognitoSignOutResult> {
  /// {@macro amplify_core.auth.sign_out_result}
  const CognitoSignOutResult._();

  /// {@macro amplify_auth_cognito_dart.model.cognito_complete_sign_out}
  const factory CognitoSignOutResult.complete() = CognitoCompleteSignOut._;

  /// {@macro amplify_auth_cognito_dart.model.cognito_failed_sign_out}
  const factory CognitoSignOutResult.failed(AuthException exception) =
      CognitoFailedSignOut._;

  /// {@macro amplify_auth_cognito_dart.model.cognito_partial_sign_out}
  const factory CognitoSignOutResult.partial({
    HostedUiException? hostedUiException,
    GlobalSignOutException? globalSignOutException,
    RevokeTokenException? revokeTokenException,
    InvalidTokenException? invalidTokenException,
  }) = CognitoPartialSignOut._;

  /// Whether credentials have been cleared from the local device.
  bool get signedOutLocally;

  @override
  List<Object?> get props => [signedOutLocally];

  @override
  String get runtimeTypeName => 'CognitoSignOutResult';

  @override
  Map<String, Object?> toJson() => {'signedOutLocally': signedOutLocally};
}

/// {@template amplify_auth_cognito_dart.model.cognito_complete_sign_out}
/// The result of a call to `Amplify.Auth.signOut`.
/// {@endtemplate}
final class CognitoCompleteSignOut extends CognitoSignOutResult {
  /// {@macro amplify_auth_cognito_dart.model.cognito_complete_sign_out}
  const CognitoCompleteSignOut._() : super._();

  @override
  bool get signedOutLocally => true;
}

/// {@template amplify_auth_cognito_dart.model.cognito_failed_sign_out}
/// A sign out which did not complete. The user will remain signed in.
/// {@endtemplate}
final class CognitoFailedSignOut extends CognitoSignOutResult {
  /// {@macro amplify_auth_cognito_dart.model.cognito_failed_sign_out}
  const CognitoFailedSignOut._(this.exception) : super._();

  /// The exception that occurred during sign out.
  final AuthException exception;

  @override
  bool get signedOutLocally => false;

  @override
  List<Object?> get props => [exception, signedOutLocally];

  @override
  Map<String, Object?> toJson() => {
    'exception': exception.toString(),
    'signedOutLocally': signedOutLocally,
  };
}

/// {@template amplify_auth_cognito_dart.model.cognito_partial_sign_out}
/// A partial success during sign out where credentials have been cleared
/// from the device.
/// {@endtemplate}
final class CognitoPartialSignOut extends CognitoSignOutResult {
  /// {@macro amplify_auth_cognito_dart.model.cognito_partial_sign_out}
  const CognitoPartialSignOut._({
    this.hostedUiException,
    this.globalSignOutException,
    this.revokeTokenException,
    this.invalidTokenException,
  }) : super._();

  /// The exception that occurred during Hosted UI sign out.
  final HostedUiException? hostedUiException;

  /// The exception that occurred during global sign out.
  final GlobalSignOutException? globalSignOutException;

  /// The exception that occurred while revoking the token.
  final RevokeTokenException? revokeTokenException;

  /// The exception that occurred while signing out with an invalid userpool token.
  final InvalidTokenException? invalidTokenException;

  @override
  bool get signedOutLocally => true;

  @override
  List<Object?> get props => [
    hostedUiException,
    globalSignOutException,
    revokeTokenException,
    invalidTokenException,
    signedOutLocally,
  ];

  @override
  Map<String, Object?> toJson() => {
    'hostedUiException': hostedUiException?.toString(),
    'globalSignOutException': globalSignOutException?.toString(),
    'revokeTokenException': revokeTokenException?.toString(),
    'invalidTokenException': invalidTokenException?.toString(),
    'signedOutLocally': signedOutLocally,
  };
}

/// {@template amplify_auth_cognito_dart.model.signout.hosted_ui_exception}
/// Exception thrown trying to sign out with an invalid userpool token (one or more of the Id, Access, or Refresh Token).
/// {@endtemplate}
class InvalidTokenException extends AuthServiceException {
  /// {@macro amplify_auth_cognito_dart.model.signout.invalid_token_exception}
  const InvalidTokenException({super.underlyingException})
    : super(
        'The provided user pool token is invalid',
        recoverySuggestion: 'See underlyingException for more details',
      );

  @override
  String get runtimeTypeName => 'InvalidTokenException';
}

/// {@template amplify_auth_cognito_dart.model.signout.hosted_ui_exception}
/// Exception thrown trying to sign out of Hosted UI.
/// {@endtemplate}
final class HostedUiException extends UnknownException {
  /// {@macro amplify_auth_cognito_dart.model.signout.hosted_ui_exception}
  const HostedUiException({super.underlyingException})
    : super(
        'Failed to perform Hosted UI sign out',
        recoverySuggestion: 'See underlyingException for more details',
      );

  @override
  String get runtimeTypeName => 'HostedUiException';
}

/// {@template amplify_auth_cognito_dart.model.signout.global_sign_out_exception}
/// Exception thrown trying to sign out the user globally.
/// {@endtemplate}
final class GlobalSignOutException extends AuthServiceException {
  /// {@macro amplify_auth_cognito_dart.model.signout.global_sign_out_exception}
  const GlobalSignOutException({
    required this.accessToken,
    super.underlyingException,
  }) : super(
         'Failed to sign out globally',
         recoverySuggestion: 'See underlyingException for more details',
       );

  /// The access token which failed global sign out.
  ///
  /// Can be used to retry the operation.
  final String accessToken;

  @override
  String get runtimeTypeName => 'GlobalSignOutException';
}

/// {@template amplify_auth_cognito_dart.model.signout.revoke_token_exception}
/// Exception thrown trying to revoke the user's token.
/// {@endtemplate}
final class RevokeTokenException extends AuthServiceException {
  /// {@macro amplify_auth_cognito_dart.model.signout.revoke_token_exception}
  const RevokeTokenException({
    required this.refreshToken,
    super.underlyingException,
  }) : super(
         'Failed to revoke token',
         recoverySuggestion: 'See underlyingException for more details',
       );

  /// The refresh token which failed to revoke.
  ///
  /// Can be used to retry the operation.
  final String refreshToken;

  @override
  String get runtimeTypeName => 'RevokeTokenException';
}
