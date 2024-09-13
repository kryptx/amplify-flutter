// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package com.amazonaws.amplify.amplify_datastore.types.model

import com.amazonaws.amplify.amplify_datastore.util.cast
import com.amplifyframework.core.model.CustomTypeSchema
import com.amplifyframework.core.model.SerializedCustomType
import com.amplifyframework.core.model.temporal.Temporal
import java.lang.Exception

data class FlutterSerializedCustomType private constructor(
    private val serializedData: Map<String, Any?>,
    private val customTypeName: String
) {
    fun toMap(): Map<String, Any> {
        val cleanedSerializedData: Map<String, Any> = serializedData.filterValues { it != null }.cast()

        val modelNameMap = mapOf("customTypeName" to customTypeName)

        return cleanedSerializedData+modelNameMap
    }

    companion object {
        fun fromSerializedCustomType(serializedCustomType: SerializedCustomType): FlutterSerializedCustomType {
            val parsedData = parseSerializedDataMap(
                serializedCustomType.serializedData,
                serializedCustomType.customTypeSchema!!
            )
            val parsedName = parseCustomTypeName(serializedCustomType.customTypeName)
            return FlutterSerializedCustomType(parsedData, parsedName)
        }

        fun fromMap(map: Map<String, Any>): FlutterSerializedCustomType {
            val parsedData = map.mapValues { (_, value) ->
                when (value) {
                    is Map<*, *> -> fromMap(value as Map<String, Any>).toMap()
                    is List<*> -> value.map { item ->
                        if (item is Map<*, *>) fromMap(item as Map<String, Any>).toMap()
                        else item
                    }
                    else -> value
                }
            }
            val customTypeName = map["customTypeName"] as? String ?: ""
            return FlutterSerializedCustomType(parsedData, customTypeName)
        }

        private fun parseCustomTypeName(customTypeName: String?): String = customTypeName ?: ""

        private fun parseSerializedDataMap(
            serializedData: Map<String, Any>,
            customTypeSchema: CustomTypeSchema
        ): Map<String, Any?> {
            if (serializedData.isEmpty()) {
                throw Exception(
                    "FlutterSerializedCustomType - no serializedData for ${customTypeSchema.name}"
                )
            }

            return serializedData.mapValues {
                val field = customTypeSchema.fields[it.key]!!
                when (val value: Any = it.value) {
                    is Temporal.DateTime -> value.format()
                    is Temporal.Date -> value.format()
                    is Temporal.Time -> value.format()
                    is Temporal.Timestamp -> value.secondsSinceEpoch
                    is SerializedCustomType -> fromSerializedCustomType(value).toMap()
                    is List<*> -> {
                        if (field.isCustomType) {
                            value.map { item ->
                                when (item) {
                                    is SerializedCustomType -> fromSerializedCustomType(item).toMap()
                                    is Map<*, *> -> fromMap(item as Map<String, Any>).toMap()
                                    else -> throw Exception("FlutterSerializedCustomType - unknown item in list: $item")
                                }
                            }
                        } else {
                            value.map { item ->
                                FlutterFieldUtil.convertValueByFieldType(field.targetType, item)
                            }
                        }
                    }
                    else -> FlutterFieldUtil.convertValueByFieldType(field.targetType, value)
                }
            }
        }
    }
}
