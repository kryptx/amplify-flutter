/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';

/** This is an auto generated class representing the StringListTypeModel type in your schema. */
class StringListTypeModel extends amplify_core.Model {
  static const classType = const _StringListTypeModelModelType();
  final String id;
  final List<String>? _value;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
    '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.',
  )
  @override
  String getId() => id;

  StringListTypeModelModelIdentifier get modelIdentifier {
    return StringListTypeModelModelIdentifier(id: id);
  }

  List<String>? get value {
    return _value;
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const StringListTypeModel._internal({
    required this.id,
    value,
    createdAt,
    updatedAt,
  }) : _value = value,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  factory StringListTypeModel({String? id, List<String>? value}) {
    return StringListTypeModel._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      value: value != null ? List<String>.unmodifiable(value) : value,
    );
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringListTypeModel &&
        id == other.id &&
        DeepCollectionEquality().equals(_value, other._value);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("StringListTypeModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write(
      "value=" + (_value != null ? _value!.toString() : "null") + ", ",
    );
    buffer.write(
      "createdAt=" +
          (_createdAt != null ? _createdAt!.format() : "null") +
          ", ",
    );
    buffer.write(
      "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"),
    );
    buffer.write("}");

    return buffer.toString();
  }

  StringListTypeModel copyWith({List<String>? value}) {
    return StringListTypeModel._internal(id: id, value: value ?? this.value);
  }

  StringListTypeModel copyWithModelFieldValues({
    ModelFieldValue<List<String>?>? value,
  }) {
    return StringListTypeModel._internal(
      id: id,
      value: value == null ? this.value : value.value,
    );
  }

  StringListTypeModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      _value = json['value']?.cast<String>(),
      _createdAt = json['createdAt'] != null
          ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
          : null,
      _updatedAt = json['updatedAt'] != null
          ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
          : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': _value,
    'createdAt': _createdAt?.format(),
    'updatedAt': _updatedAt?.format(),
  };

  Map<String, Object?> toMap() => {
    'id': id,
    'value': _value,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
  };

  static final amplify_core.QueryModelIdentifier<
    StringListTypeModelModelIdentifier
  >
  MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<StringListTypeModelModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final VALUE = amplify_core.QueryField(fieldName: "value");
  static var schema = amplify_core.Model.defineSchema(
    define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = "StringListTypeModel";
      modelSchemaDefinition.pluralName = "StringListTypeModels";

      modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.field(
          key: StringListTypeModel.VALUE,
          isRequired: false,
          isArray: true,
          ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.collection,
            ofModelName: amplify_core.ModelFieldTypeEnum.string.name,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
          fieldName: 'createdAt',
          isRequired: false,
          isReadOnly: true,
          ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.dateTime,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
          fieldName: 'updatedAt',
          isRequired: false,
          isReadOnly: true,
          ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.dateTime,
          ),
        ),
      );
    },
  );
}

class _StringListTypeModelModelType
    extends amplify_core.ModelType<StringListTypeModel> {
  const _StringListTypeModelModelType();

  @override
  StringListTypeModel fromJson(Map<String, dynamic> jsonData) {
    return StringListTypeModel.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'StringListTypeModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [StringListTypeModel] in your schema.
 */
class StringListTypeModelModelIdentifier
    implements amplify_core.ModelIdentifier<StringListTypeModel> {
  final String id;

  /** Create an instance of StringListTypeModelModelIdentifier using [id] the primary key. */
  const StringListTypeModelModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap().entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'StringListTypeModelModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is StringListTypeModelModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
