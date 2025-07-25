// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'oauth_outputs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthOutputs _$OAuthOutputsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OAuthOutputs',
      json,
      ($checkedConvert) {
        final val = OAuthOutputs(
          identityProviders: $checkedConvert(
            'identity_providers',
            (v) => (v as List<dynamic>)
                .map((e) => $enumDecode(_$IdentityProviderEnumMap, e))
                .toList(),
          ),
          domain: $checkedConvert('domain', (v) => v as String),
          scopes: $checkedConvert(
            'scopes',
            (v) => (v as List<dynamic>).map((e) => e as String).toList(),
          ),
          redirectSignInUri: $checkedConvert(
            'redirect_sign_in_uri',
            (v) => (v as List<dynamic>).map((e) => e as String).toList(),
          ),
          signInUri: $checkedConvert('sign_in_uri', (v) => v as String?),
          signInUriQueryParameters: $checkedConvert(
            'sign_in_uri_query_parameters',
            (v) => (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(k, e as String),
            ),
          ),
          redirectSignOutUri: $checkedConvert(
            'redirect_sign_out_uri',
            (v) => (v as List<dynamic>).map((e) => e as String).toList(),
          ),
          signOutUri: $checkedConvert('sign_out_uri', (v) => v as String?),
          signOutUriQueryParameters: $checkedConvert(
            'sign_out_uri_query_parameters',
            (v) => (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(k, e as String),
            ),
          ),
          tokenUri: $checkedConvert('token_uri', (v) => v as String?),
          responseType: $checkedConvert(
            'response_type',
            (v) => $enumDecode(_$OAuthResponseTypeEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'identityProviders': 'identity_providers',
        'redirectSignInUri': 'redirect_sign_in_uri',
        'signInUri': 'sign_in_uri',
        'signInUriQueryParameters': 'sign_in_uri_query_parameters',
        'redirectSignOutUri': 'redirect_sign_out_uri',
        'signOutUri': 'sign_out_uri',
        'signOutUriQueryParameters': 'sign_out_uri_query_parameters',
        'tokenUri': 'token_uri',
        'responseType': 'response_type',
      },
    );

Map<String, dynamic> _$OAuthOutputsToJson(OAuthOutputs instance) =>
    <String, dynamic>{
      'identity_providers': instance.identityProviders
          .map((e) => _$IdentityProviderEnumMap[e]!)
          .toList(),
      'domain': instance.domain,
      'scopes': instance.scopes,
      'redirect_sign_in_uri': instance.redirectSignInUri,
      if (instance.signInUri case final value?) 'sign_in_uri': value,
      if (instance.signInUriQueryParameters case final value?)
        'sign_in_uri_query_parameters': value,
      'redirect_sign_out_uri': instance.redirectSignOutUri,
      if (instance.signOutUri case final value?) 'sign_out_uri': value,
      if (instance.signOutUriQueryParameters case final value?)
        'sign_out_uri_query_parameters': value,
      if (instance.tokenUri case final value?) 'token_uri': value,
      'response_type': _$OAuthResponseTypeEnumMap[instance.responseType]!,
    };

const _$IdentityProviderEnumMap = {
  IdentityProvider.facebook: 'FACEBOOK',
  IdentityProvider.google: 'GOOGLE',
  IdentityProvider.amazon: 'LOGIN_WITH_AMAZON',
  IdentityProvider.apple: 'SIGN_IN_WITH_APPLE',
};

const _$OAuthResponseTypeEnumMap = {
  OAuthResponseType.code: 'code',
  OAuthResponseType.token: 'token',
};
