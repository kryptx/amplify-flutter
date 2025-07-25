// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_payload_with_xml_namespace_input_output.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HttpPayloadWithXmlNamespaceInputOutput
    extends HttpPayloadWithXmlNamespaceInputOutput {
  @override
  final PayloadWithXmlNamespace? nested;

  factory _$HttpPayloadWithXmlNamespaceInputOutput([
    void Function(HttpPayloadWithXmlNamespaceInputOutputBuilder)? updates,
  ]) => (HttpPayloadWithXmlNamespaceInputOutputBuilder()..update(updates))
      ._build();

  _$HttpPayloadWithXmlNamespaceInputOutput._({this.nested}) : super._();
  @override
  HttpPayloadWithXmlNamespaceInputOutput rebuild(
    void Function(HttpPayloadWithXmlNamespaceInputOutputBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HttpPayloadWithXmlNamespaceInputOutputBuilder toBuilder() =>
      HttpPayloadWithXmlNamespaceInputOutputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HttpPayloadWithXmlNamespaceInputOutput &&
        nested == other.nested;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nested.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class HttpPayloadWithXmlNamespaceInputOutputBuilder
    implements
        Builder<
          HttpPayloadWithXmlNamespaceInputOutput,
          HttpPayloadWithXmlNamespaceInputOutputBuilder
        > {
  _$HttpPayloadWithXmlNamespaceInputOutput? _$v;

  PayloadWithXmlNamespaceBuilder? _nested;
  PayloadWithXmlNamespaceBuilder get nested =>
      _$this._nested ??= PayloadWithXmlNamespaceBuilder();
  set nested(PayloadWithXmlNamespaceBuilder? nested) => _$this._nested = nested;

  HttpPayloadWithXmlNamespaceInputOutputBuilder();

  HttpPayloadWithXmlNamespaceInputOutputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nested = $v.nested?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HttpPayloadWithXmlNamespaceInputOutput other) {
    _$v = other as _$HttpPayloadWithXmlNamespaceInputOutput;
  }

  @override
  void update(
    void Function(HttpPayloadWithXmlNamespaceInputOutputBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HttpPayloadWithXmlNamespaceInputOutput build() => _build();

  _$HttpPayloadWithXmlNamespaceInputOutput _build() {
    _$HttpPayloadWithXmlNamespaceInputOutput _$result;
    try {
      _$result =
          _$v ??
          _$HttpPayloadWithXmlNamespaceInputOutput._(nested: _nested?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nested';
        _nested?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HttpPayloadWithXmlNamespaceInputOutput',
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
