// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library aws_json1_1_v2.machine_learning.model.prediction; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:aws_json1_1_v2/src/machine_learning/model/details_attributes.dart'
    as _i2;
import 'package:built_collection/built_collection.dart' as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i4;

part 'prediction.g.dart';

abstract class Prediction
    with _i1.AWSEquatable<Prediction>
    implements Built<Prediction, PredictionBuilder> {
  factory Prediction({
    String? predictedLabel,
    double? predictedValue,
    Map<String, double>? predictedScores,
    Map<_i2.DetailsAttributes, String>? details,
  }) {
    return _$Prediction._(
      predictedLabel: predictedLabel,
      predictedValue: predictedValue,
      predictedScores:
          predictedScores == null ? null : _i3.BuiltMap(predictedScores),
      details: details == null ? null : _i3.BuiltMap(details),
    );
  }

  factory Prediction.build([void Function(PredictionBuilder) updates]) =
      _$Prediction;

  const Prediction._();

  static const List<_i4.SmithySerializer> serializers = [
    PredictionAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(PredictionBuilder b) {}
  String? get predictedLabel;
  double? get predictedValue;
  _i3.BuiltMap<String, double>? get predictedScores;
  _i3.BuiltMap<_i2.DetailsAttributes, String>? get details;
  @override
  List<Object?> get props => [
        predictedLabel,
        predictedValue,
        predictedScores,
        details,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('Prediction');
    helper.add(
      'predictedLabel',
      predictedLabel,
    );
    helper.add(
      'predictedValue',
      predictedValue,
    );
    helper.add(
      'predictedScores',
      predictedScores,
    );
    helper.add(
      'details',
      details,
    );
    return helper.toString();
  }
}

class PredictionAwsJson11Serializer
    extends _i4.StructuredSmithySerializer<Prediction> {
  const PredictionAwsJson11Serializer() : super('Prediction');

  @override
  Iterable<Type> get types => const [
        Prediction,
        _$Prediction,
      ];
  @override
  Iterable<_i4.ShapeId> get supportedProtocols => const [
        _i4.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  Prediction deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PredictionBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'predictedLabel':
          if (value != null) {
            result.predictedLabel = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 'predictedValue':
          if (value != null) {
            result.predictedValue = (serializers.deserialize(
              value,
              specifiedType: const FullType(double),
            ) as double);
          }
          break;
        case 'predictedScores':
          if (value != null) {
            result.predictedScores.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(
                _i3.BuiltMap,
                [
                  FullType(String),
                  FullType(double),
                ],
              ),
            ) as _i3.BuiltMap<String, double>));
          }
          break;
        case 'details':
          if (value != null) {
            result.details.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(
                _i3.BuiltMap,
                [
                  FullType(_i2.DetailsAttributes),
                  FullType(String),
                ],
              ),
            ) as _i3.BuiltMap<_i2.DetailsAttributes, String>));
          }
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final payload = (object as Prediction);
    final result = <Object?>[];
    if (payload.predictedLabel != null) {
      result
        ..add('predictedLabel')
        ..add(serializers.serialize(
          payload.predictedLabel!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.predictedValue != null) {
      result
        ..add('predictedValue')
        ..add(serializers.serialize(
          payload.predictedValue!,
          specifiedType: const FullType(double),
        ));
    }
    if (payload.predictedScores != null) {
      result
        ..add('predictedScores')
        ..add(serializers.serialize(
          payload.predictedScores!,
          specifiedType: const FullType(
            _i3.BuiltMap,
            [
              FullType(String),
              FullType(double),
            ],
          ),
        ));
    }
    if (payload.details != null) {
      result
        ..add('details')
        ..add(serializers.serialize(
          payload.details!,
          specifiedType: const FullType(
            _i3.BuiltMap,
            [
              FullType(_i2.DetailsAttributes),
              FullType(String),
            ],
          ),
        ));
    }
    return result;
  }
}
