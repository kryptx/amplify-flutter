// Generated with smithy-dart 0.3.1. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,require_trailing_commas

library amplify_storage_s3_dart.s3.model.complete_multipart_upload_request; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/completed_multipart_upload.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/completed_part.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/request_payer.dart';
import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_collection/built_collection.dart' as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i1;

part 'complete_multipart_upload_request.g.dart';

abstract class CompleteMultipartUploadRequest
    with
        _i1.HttpInput<CompletedMultipartUpload>,
        _i2.AWSEquatable<CompleteMultipartUploadRequest>
    implements
        Built<
          CompleteMultipartUploadRequest,
          CompleteMultipartUploadRequestBuilder
        >,
        _i1.HasPayload<CompletedMultipartUpload> {
  factory CompleteMultipartUploadRequest({
    required String bucket,
    required String key,
    CompletedMultipartUpload? multipartUpload,
    required String uploadId,
    String? checksumCrc32,
    String? checksumCrc32C,
    String? checksumSha1,
    String? checksumSha256,
    RequestPayer? requestPayer,
    String? expectedBucketOwner,
    String? sseCustomerAlgorithm,
    String? sseCustomerKey,
    String? sseCustomerKeyMd5,
  }) {
    return _$CompleteMultipartUploadRequest._(
      bucket: bucket,
      key: key,
      multipartUpload: multipartUpload,
      uploadId: uploadId,
      checksumCrc32: checksumCrc32,
      checksumCrc32C: checksumCrc32C,
      checksumSha1: checksumSha1,
      checksumSha256: checksumSha256,
      requestPayer: requestPayer,
      expectedBucketOwner: expectedBucketOwner,
      sseCustomerAlgorithm: sseCustomerAlgorithm,
      sseCustomerKey: sseCustomerKey,
      sseCustomerKeyMd5: sseCustomerKeyMd5,
    );
  }

  factory CompleteMultipartUploadRequest.build([
    void Function(CompleteMultipartUploadRequestBuilder) updates,
  ]) = _$CompleteMultipartUploadRequest;

  const CompleteMultipartUploadRequest._();

  factory CompleteMultipartUploadRequest.fromRequest(
    CompletedMultipartUpload? payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) => CompleteMultipartUploadRequest.build((b) {
    if (payload != null) {
      b.multipartUpload.replace(payload);
    }
    if (request.headers['x-amz-checksum-crc32'] != null) {
      b.checksumCrc32 = request.headers['x-amz-checksum-crc32']!;
    }
    if (request.headers['x-amz-checksum-crc32c'] != null) {
      b.checksumCrc32C = request.headers['x-amz-checksum-crc32c']!;
    }
    if (request.headers['x-amz-checksum-sha1'] != null) {
      b.checksumSha1 = request.headers['x-amz-checksum-sha1']!;
    }
    if (request.headers['x-amz-checksum-sha256'] != null) {
      b.checksumSha256 = request.headers['x-amz-checksum-sha256']!;
    }
    if (request.headers['x-amz-request-payer'] != null) {
      b.requestPayer = RequestPayer.values.byValue(
        request.headers['x-amz-request-payer']!,
      );
    }
    if (request.headers['x-amz-expected-bucket-owner'] != null) {
      b.expectedBucketOwner = request.headers['x-amz-expected-bucket-owner']!;
    }
    if (request.headers['x-amz-server-side-encryption-customer-algorithm'] !=
        null) {
      b.sseCustomerAlgorithm =
          request.headers['x-amz-server-side-encryption-customer-algorithm']!;
    }
    if (request.headers['x-amz-server-side-encryption-customer-key'] != null) {
      b.sseCustomerKey =
          request.headers['x-amz-server-side-encryption-customer-key']!;
    }
    if (request.headers['x-amz-server-side-encryption-customer-key-MD5'] !=
        null) {
      b.sseCustomerKeyMd5 =
          request.headers['x-amz-server-side-encryption-customer-key-MD5']!;
    }
    if (request.queryParameters['uploadId'] != null) {
      b.uploadId = request.queryParameters['uploadId']!;
    }
    if (labels['bucket'] != null) {
      b.bucket = labels['bucket']!;
    }
    if (labels['key'] != null) {
      b.key = labels['key']!;
    }
  });

  static const List<_i1.SmithySerializer<CompletedMultipartUpload?>>
  serializers = [CompleteMultipartUploadRequestRestXmlSerializer()];

  /// Name of the bucket to which the multipart upload was initiated.
  ///
  /// **Directory buckets** \- When you use this operation with a directory bucket, you must use virtual-hosted-style requests in the format `_Bucket_name_.s3express-_az_id_._region_.amazonaws.com`. Path-style requests are not supported. Directory bucket names must be unique in the chosen Availability Zone. Bucket names must follow the format `_bucket\_base\_name_--_az-id_--x-s3` (for example, `_DOC-EXAMPLE-BUCKET_--_usw2-az2_--x-s3`). For information about bucket naming restrictions, see [Directory bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the _Amazon S3 User Guide_.
  ///
  /// **Access points** \- When you use this action with an access point, you must provide the alias of the access point in place of the bucket name or specify the access point ARN. When using the access point ARN, you must direct requests to the access point hostname. The access point hostname takes the form _AccessPointName_-_AccountId_.s3-accesspoint._Region_.amazonaws.com. When using this action with an access point through the Amazon Web Services SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see [Using access points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-access-points.html) in the _Amazon S3 User Guide_.
  ///
  /// Access points and Object Lambda access points are not supported by directory buckets.
  ///
  /// **S3 on Outposts** \- When you use this action with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form `_AccessPointName_-_AccountId_._outpostID_.s3-outposts._Region_.amazonaws.com`. When you use this action with S3 on Outposts through the Amazon Web Services SDKs, you provide the Outposts access point ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the _Amazon S3 User Guide_.
  String get bucket;

  /// Object key for which the multipart upload was initiated.
  String get key;

  /// The container for the multipart upload request information.
  CompletedMultipartUpload? get multipartUpload;

  /// ID for the initiated multipart upload.
  String get uploadId;

  /// This header can be used as a data integrity check to verify that the data received is the same data that was originally sent. This header specifies the base64-encoded, 32-bit CRC32 checksum of the object. For more information, see [Checking object integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the _Amazon S3 User Guide_.
  String? get checksumCrc32;

  /// This header can be used as a data integrity check to verify that the data received is the same data that was originally sent. This header specifies the base64-encoded, 32-bit CRC32C checksum of the object. For more information, see [Checking object integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the _Amazon S3 User Guide_.
  String? get checksumCrc32C;

  /// This header can be used as a data integrity check to verify that the data received is the same data that was originally sent. This header specifies the base64-encoded, 160-bit SHA-1 digest of the object. For more information, see [Checking object integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the _Amazon S3 User Guide_.
  String? get checksumSha1;

  /// This header can be used as a data integrity check to verify that the data received is the same data that was originally sent. This header specifies the base64-encoded, 256-bit SHA-256 digest of the object. For more information, see [Checking object integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the _Amazon S3 User Guide_.
  String? get checksumSha256;

  /// Confirms that the requester knows that they will be charged for the request. Bucket owners need not specify this parameter in their requests. If either the source or destination S3 bucket has Requester Pays enabled, the requester will pay for corresponding charges to copy the object. For information about downloading objects from Requester Pays buckets, see [Downloading Objects in Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html) in the _Amazon S3 User Guide_.
  ///
  /// This functionality is not supported for directory buckets.
  RequestPayer? get requestPayer;

  /// The account ID of the expected bucket owner. If the account ID that you provide does not match the actual owner of the bucket, the request fails with the HTTP status code `403 Forbidden` (access denied).
  String? get expectedBucketOwner;

  /// The server-side encryption (SSE) algorithm used to encrypt the object. This parameter is required only when the object was created using a checksum algorithm or if your bucket policy requires the use of SSE-C. For more information, see [Protecting data using SSE-C keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html#ssec-require-condition-key) in the _Amazon S3 User Guide_.
  ///
  /// This functionality is not supported for directory buckets.
  String? get sseCustomerAlgorithm;

  /// The server-side encryption (SSE) customer managed key. This parameter is needed only when the object was created using a checksum algorithm. For more information, see [Protecting data using SSE-C keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the _Amazon S3 User Guide_.
  ///
  /// This functionality is not supported for directory buckets.
  String? get sseCustomerKey;

  /// The MD5 server-side encryption (SSE) customer managed key. This parameter is needed only when the object was created using a checksum algorithm. For more information, see [Protecting data using SSE-C keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the _Amazon S3 User Guide_.
  ///
  /// This functionality is not supported for directory buckets.
  String? get sseCustomerKeyMd5;
  @override
  String labelFor(String key) {
    switch (key) {
      case 'Bucket':
        return bucket;
      case 'Key':
        return this.key;
    }
    throw _i1.MissingLabelException(this, key);
  }

  @override
  CompletedMultipartUpload? getPayload() =>
      multipartUpload ?? CompletedMultipartUpload();

  @override
  List<Object?> get props => [
    bucket,
    key,
    multipartUpload,
    uploadId,
    checksumCrc32,
    checksumCrc32C,
    checksumSha1,
    checksumSha256,
    requestPayer,
    expectedBucketOwner,
    sseCustomerAlgorithm,
    sseCustomerKey,
    sseCustomerKeyMd5,
  ];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('CompleteMultipartUploadRequest')
      ..add('bucket', bucket)
      ..add('key', key)
      ..add('multipartUpload', multipartUpload)
      ..add('uploadId', uploadId)
      ..add('checksumCrc32', checksumCrc32)
      ..add('checksumCrc32C', checksumCrc32C)
      ..add('checksumSha1', checksumSha1)
      ..add('checksumSha256', checksumSha256)
      ..add('requestPayer', requestPayer)
      ..add('expectedBucketOwner', expectedBucketOwner)
      ..add('sseCustomerAlgorithm', sseCustomerAlgorithm)
      ..add('sseCustomerKey', '***SENSITIVE***')
      ..add('sseCustomerKeyMd5', sseCustomerKeyMd5);
    return helper.toString();
  }
}

class CompleteMultipartUploadRequestRestXmlSerializer
    extends _i1.StructuredSmithySerializer<CompletedMultipartUpload> {
  const CompleteMultipartUploadRequestRestXmlSerializer()
    : super('CompleteMultipartUploadRequest');

  @override
  Iterable<Type> get types => const [
    CompleteMultipartUploadRequest,
    _$CompleteMultipartUploadRequest,
  ];

  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
    _i1.ShapeId(namespace: 'aws.protocols', shape: 'restXml'),
  ];

  @override
  CompletedMultipartUpload deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompletedMultipartUploadBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      if (value == null) {
        continue;
      }
      switch (key) {
        case 'Part':
          result.parts.add(
            (serializers.deserialize(
                  value,
                  specifiedType: const FullType(CompletedPart),
                )
                as CompletedPart),
          );
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CompletedMultipartUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[
      const _i1.XmlElementName(
        'CompleteMultipartUpload',
        _i1.XmlNamespace('http://s3.amazonaws.com/doc/2006-03-01/'),
      ),
    ];
    final CompletedMultipartUpload(:parts) = object;
    if (parts != null) {
      result$.addAll(
        const _i1.XmlBuiltListSerializer(memberName: 'Part').serialize(
          serializers,
          parts,
          specifiedType: const FullType(_i3.BuiltList, [
            FullType(CompletedPart),
          ]),
        ),
      );
    }
    return result$;
  }
}
