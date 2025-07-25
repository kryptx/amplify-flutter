// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignUpResponse extends SignUpResponse {
  @override
  final bool userConfirmed;
  @override
  final CodeDeliveryDetailsType? codeDeliveryDetails;
  @override
  final String userSub;
  @override
  final String? session;

  factory _$SignUpResponse([void Function(SignUpResponseBuilder)? updates]) =>
      (SignUpResponseBuilder()..update(updates))._build();

  _$SignUpResponse._({
    required this.userConfirmed,
    this.codeDeliveryDetails,
    required this.userSub,
    this.session,
  }) : super._();
  @override
  SignUpResponse rebuild(void Function(SignUpResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignUpResponseBuilder toBuilder() => SignUpResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignUpResponse &&
        userConfirmed == other.userConfirmed &&
        codeDeliveryDetails == other.codeDeliveryDetails &&
        userSub == other.userSub &&
        session == other.session;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userConfirmed.hashCode);
    _$hash = $jc(_$hash, codeDeliveryDetails.hashCode);
    _$hash = $jc(_$hash, userSub.hashCode);
    _$hash = $jc(_$hash, session.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class SignUpResponseBuilder
    implements Builder<SignUpResponse, SignUpResponseBuilder> {
  _$SignUpResponse? _$v;

  bool? _userConfirmed;
  bool? get userConfirmed => _$this._userConfirmed;
  set userConfirmed(bool? userConfirmed) =>
      _$this._userConfirmed = userConfirmed;

  CodeDeliveryDetailsTypeBuilder? _codeDeliveryDetails;
  CodeDeliveryDetailsTypeBuilder get codeDeliveryDetails =>
      _$this._codeDeliveryDetails ??= CodeDeliveryDetailsTypeBuilder();
  set codeDeliveryDetails(
    CodeDeliveryDetailsTypeBuilder? codeDeliveryDetails,
  ) => _$this._codeDeliveryDetails = codeDeliveryDetails;

  String? _userSub;
  String? get userSub => _$this._userSub;
  set userSub(String? userSub) => _$this._userSub = userSub;

  String? _session;
  String? get session => _$this._session;
  set session(String? session) => _$this._session = session;

  SignUpResponseBuilder() {
    SignUpResponse._init(this);
  }

  SignUpResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userConfirmed = $v.userConfirmed;
      _codeDeliveryDetails = $v.codeDeliveryDetails?.toBuilder();
      _userSub = $v.userSub;
      _session = $v.session;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignUpResponse other) {
    _$v = other as _$SignUpResponse;
  }

  @override
  void update(void Function(SignUpResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignUpResponse build() => _build();

  _$SignUpResponse _build() {
    _$SignUpResponse _$result;
    try {
      _$result =
          _$v ??
          _$SignUpResponse._(
            userConfirmed: BuiltValueNullFieldError.checkNotNull(
              userConfirmed,
              r'SignUpResponse',
              'userConfirmed',
            ),
            codeDeliveryDetails: _codeDeliveryDetails?.build(),
            userSub: BuiltValueNullFieldError.checkNotNull(
              userSub,
              r'SignUpResponse',
              'userSub',
            ),
            session: session,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'codeDeliveryDetails';
        _codeDeliveryDetails?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SignUpResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
