// Generated with smithy-dart 0.3.2. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,unnecessary_library_name

library amplify_auth_cognito_dart.cognito_identity_provider.model.sms_mfa_settings_type; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'sms_mfa_settings_type.g.dart';

/// A user's preference for using SMS message multi-factor authentication (MFA). Turns SMS MFA on and off, and can set SMS as preferred when other MFA options are available. You can't turn off SMS MFA for any of your users when MFA is required in your user pool; you can only set the type that your user prefers.
abstract class SmsMfaSettingsType
    with _i1.AWSEquatable<SmsMfaSettingsType>
    implements Built<SmsMfaSettingsType, SmsMfaSettingsTypeBuilder> {
  /// A user's preference for using SMS message multi-factor authentication (MFA). Turns SMS MFA on and off, and can set SMS as preferred when other MFA options are available. You can't turn off SMS MFA for any of your users when MFA is required in your user pool; you can only set the type that your user prefers.
  factory SmsMfaSettingsType({bool? enabled, bool? preferredMfa}) {
    enabled ??= false;
    preferredMfa ??= false;
    return _$SmsMfaSettingsType._(enabled: enabled, preferredMfa: preferredMfa);
  }

  /// A user's preference for using SMS message multi-factor authentication (MFA). Turns SMS MFA on and off, and can set SMS as preferred when other MFA options are available. You can't turn off SMS MFA for any of your users when MFA is required in your user pool; you can only set the type that your user prefers.
  factory SmsMfaSettingsType.build([
    void Function(SmsMfaSettingsTypeBuilder) updates,
  ]) = _$SmsMfaSettingsType;

  const SmsMfaSettingsType._();

  static const List<_i2.SmithySerializer<SmsMfaSettingsType>> serializers = [
    SmsMfaSettingsTypeAwsJson11Serializer(),
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(SmsMfaSettingsTypeBuilder b) {
    b
      ..enabled = false
      ..preferredMfa = false;
  }

  /// Specifies whether SMS message MFA is activated. If an MFA type is activated for a user, the user will be prompted for MFA during all sign-in attempts, unless device tracking is turned on and the device has been trusted.
  bool get enabled;

  /// Specifies whether SMS is the preferred MFA method. If true, your user pool prompts the specified user for a code delivered by SMS message after username-password sign-in succeeds.
  bool get preferredMfa;
  @override
  List<Object?> get props => [enabled, preferredMfa];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('SmsMfaSettingsType')
      ..add('enabled', enabled)
      ..add('preferredMfa', preferredMfa);
    return helper.toString();
  }
}

class SmsMfaSettingsTypeAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<SmsMfaSettingsType> {
  const SmsMfaSettingsTypeAwsJson11Serializer() : super('SmsMfaSettingsType');

  @override
  Iterable<Type> get types => const [SmsMfaSettingsType, _$SmsMfaSettingsType];

  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
    _i2.ShapeId(namespace: 'aws.protocols', shape: 'awsJson1_1'),
  ];

  @override
  SmsMfaSettingsType deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SmsMfaSettingsTypeBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'Enabled':
          result.enabled =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool);
        case 'PreferredMfa':
          result.preferredMfa =
              (serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool);
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SmsMfaSettingsType object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[];
    final SmsMfaSettingsType(:enabled, :preferredMfa) = object;
    result$.addAll([
      'Enabled',
      serializers.serialize(enabled, specifiedType: const FullType(bool)),
      'PreferredMfa',
      serializers.serialize(preferredMfa, specifiedType: const FullType(bool)),
    ]);
    return result$;
  }
}
