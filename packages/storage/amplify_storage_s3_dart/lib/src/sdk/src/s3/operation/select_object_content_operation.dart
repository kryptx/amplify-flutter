// Generated with smithy-dart 0.3.1. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,require_trailing_commas

library amplify_storage_s3_dart.s3.operation.select_object_content_operation; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i5;

import 'package:amplify_storage_s3_dart/src/sdk/src/s3/common/endpoint_resolver.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/common/serializers.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/select_object_content_event_stream.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/select_object_content_output.dart';
import 'package:amplify_storage_s3_dart/src/sdk/src/s3/model/select_object_content_request.dart';
import 'package:aws_common/aws_common.dart' as _i4;
import 'package:aws_signature_v4/aws_signature_v4.dart' as _i3;
import 'package:smithy/smithy.dart' as _i1;
import 'package:smithy_aws/smithy_aws.dart' as _i2;

/// This operation is not supported by directory buckets.
///
/// This action filters the contents of an Amazon S3 object based on a simple structured query language (SQL) statement. In the request, along with the SQL expression, you must also specify a data serialization format (JSON, CSV, or Apache Parquet) of the object. Amazon S3 uses this format to parse object data into records, and returns only records that match the specified SQL expression. You must also specify the data serialization format for the response.
///
/// This functionality is not supported for Amazon S3 on Outposts.
///
/// For more information about Amazon S3 Select, see [Selecting Content from Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/selecting-content-from-objects.html) and [SELECT Command](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-glacier-select-sql-reference-select.html) in the _Amazon S3 User Guide_.
///
/// Permissions
///
/// You must have the `s3:GetObject` permission for this operation. Amazon S3 Select does not support anonymous access. For more information about permissions, see [Specifying Permissions in a Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html) in the _Amazon S3 User Guide_.
///
/// Object Data Formats
///
/// You can use Amazon S3 Select to query objects that have the following format properties:
///
/// *   _CSV, JSON, and Parquet_ \- Objects must be in CSV, JSON, or Parquet format.
///
/// *   _UTF-8_ \- UTF-8 is the only encoding type Amazon S3 Select supports.
///
/// *   _GZIP or BZIP2_ \- CSV and JSON files can be compressed using GZIP or BZIP2. GZIP and BZIP2 are the only compression formats that Amazon S3 Select supports for CSV and JSON files. Amazon S3 Select supports columnar compression for Parquet using GZIP or Snappy. Amazon S3 Select does not support whole-object compression for Parquet objects.
///
/// *   _Server-side encryption_ \- Amazon S3 Select supports querying objects that are protected with server-side encryption.
///
///     For objects that are encrypted with customer-provided encryption keys (SSE-C), you must use HTTPS, and you must use the headers that are documented in the [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html). For more information about SSE-C, see [Server-Side Encryption (Using Customer-Provided Encryption Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the _Amazon S3 User Guide_.
///
///     For objects that are encrypted with Amazon S3 managed keys (SSE-S3) and Amazon Web Services KMS keys (SSE-KMS), server-side encryption is handled transparently, so you don't need to specify anything. For more information about server-side encryption, including SSE-S3 and SSE-KMS, see [Protecting Data Using Server-Side Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) in the _Amazon S3 User Guide_.
///
///
/// Working with the Response Body
///
/// Given the response size is unknown, Amazon S3 Select streams the response as a series of messages and includes a `Transfer-Encoding` header with `chunked` as its value in the response. For more information, see [Appendix: SelectObjectContent Response](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html).
///
/// GetObject Support
///
/// The `SelectObjectContent` action does not support the following `GetObject` functionality. For more information, see [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html).
///
/// *   `Range`: Although you can specify a scan range for an Amazon S3 Select request (see [SelectObjectContentRequest - ScanRange](https://docs.aws.amazon.com/AmazonS3/latest/API/API_SelectObjectContent.html#AmazonS3-SelectObjectContent-request-ScanRange) in the request parameters), you cannot specify the range of bytes of an object to return.
///
/// *   The `GLACIER`, `DEEP_ARCHIVE`, and `REDUCED_REDUNDANCY` storage classes, or the `ARCHIVE_ACCESS` and `DEEP\_ARCHIVE\_ACCESS` access tiers of the `INTELLIGENT_TIERING` storage class: You cannot query objects in the `GLACIER`, `DEEP_ARCHIVE`, or `REDUCED_REDUNDANCY` storage classes, nor objects in the `ARCHIVE_ACCESS` or `DEEP\_ARCHIVE\_ACCESS` access tiers of the `INTELLIGENT_TIERING` storage class. For more information about storage classes, see [Using Amazon S3 storage classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html) in the _Amazon S3 User Guide_.
///
///
/// Special Errors
///
/// For a list of special errors for this operation, see [List of SELECT Object Content Error Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#SelectObjectContentErrorCodeList)
///
/// The following operations are related to `SelectObjectContent`:
///
/// *   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
///
/// *   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html)
///
/// *   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)
class SelectObjectContentOperation
    extends
        _i1.HttpOperation<
          SelectObjectContentRequestPayload,
          SelectObjectContentRequest,
          SelectObjectContentEventStream,
          SelectObjectContentOutput
        > {
  /// This operation is not supported by directory buckets.
  ///
  /// This action filters the contents of an Amazon S3 object based on a simple structured query language (SQL) statement. In the request, along with the SQL expression, you must also specify a data serialization format (JSON, CSV, or Apache Parquet) of the object. Amazon S3 uses this format to parse object data into records, and returns only records that match the specified SQL expression. You must also specify the data serialization format for the response.
  ///
  /// This functionality is not supported for Amazon S3 on Outposts.
  ///
  /// For more information about Amazon S3 Select, see [Selecting Content from Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/selecting-content-from-objects.html) and [SELECT Command](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-glacier-select-sql-reference-select.html) in the _Amazon S3 User Guide_.
  ///
  /// Permissions
  ///
  /// You must have the `s3:GetObject` permission for this operation. Amazon S3 Select does not support anonymous access. For more information about permissions, see [Specifying Permissions in a Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html) in the _Amazon S3 User Guide_.
  ///
  /// Object Data Formats
  ///
  /// You can use Amazon S3 Select to query objects that have the following format properties:
  ///
  /// *   _CSV, JSON, and Parquet_ \- Objects must be in CSV, JSON, or Parquet format.
  ///
  /// *   _UTF-8_ \- UTF-8 is the only encoding type Amazon S3 Select supports.
  ///
  /// *   _GZIP or BZIP2_ \- CSV and JSON files can be compressed using GZIP or BZIP2. GZIP and BZIP2 are the only compression formats that Amazon S3 Select supports for CSV and JSON files. Amazon S3 Select supports columnar compression for Parquet using GZIP or Snappy. Amazon S3 Select does not support whole-object compression for Parquet objects.
  ///
  /// *   _Server-side encryption_ \- Amazon S3 Select supports querying objects that are protected with server-side encryption.
  ///
  ///     For objects that are encrypted with customer-provided encryption keys (SSE-C), you must use HTTPS, and you must use the headers that are documented in the [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html). For more information about SSE-C, see [Server-Side Encryption (Using Customer-Provided Encryption Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the _Amazon S3 User Guide_.
  ///
  ///     For objects that are encrypted with Amazon S3 managed keys (SSE-S3) and Amazon Web Services KMS keys (SSE-KMS), server-side encryption is handled transparently, so you don't need to specify anything. For more information about server-side encryption, including SSE-S3 and SSE-KMS, see [Protecting Data Using Server-Side Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) in the _Amazon S3 User Guide_.
  ///
  ///
  /// Working with the Response Body
  ///
  /// Given the response size is unknown, Amazon S3 Select streams the response as a series of messages and includes a `Transfer-Encoding` header with `chunked` as its value in the response. For more information, see [Appendix: SelectObjectContent Response](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html).
  ///
  /// GetObject Support
  ///
  /// The `SelectObjectContent` action does not support the following `GetObject` functionality. For more information, see [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html).
  ///
  /// *   `Range`: Although you can specify a scan range for an Amazon S3 Select request (see [SelectObjectContentRequest - ScanRange](https://docs.aws.amazon.com/AmazonS3/latest/API/API_SelectObjectContent.html#AmazonS3-SelectObjectContent-request-ScanRange) in the request parameters), you cannot specify the range of bytes of an object to return.
  ///
  /// *   The `GLACIER`, `DEEP_ARCHIVE`, and `REDUCED_REDUNDANCY` storage classes, or the `ARCHIVE_ACCESS` and `DEEP\_ARCHIVE\_ACCESS` access tiers of the `INTELLIGENT_TIERING` storage class: You cannot query objects in the `GLACIER`, `DEEP_ARCHIVE`, or `REDUCED_REDUNDANCY` storage classes, nor objects in the `ARCHIVE_ACCESS` or `DEEP\_ARCHIVE\_ACCESS` access tiers of the `INTELLIGENT_TIERING` storage class. For more information about storage classes, see [Using Amazon S3 storage classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html) in the _Amazon S3 User Guide_.
  ///
  ///
  /// Special Errors
  ///
  /// For a list of special errors for this operation, see [List of SELECT Object Content Error Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#SelectObjectContentErrorCodeList)
  ///
  /// The following operations are related to `SelectObjectContent`:
  ///
  /// *   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
  ///
  /// *   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html)
  ///
  /// *   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)
  SelectObjectContentOperation({
    required String region,
    Uri? baseUri,
    _i2.S3ClientConfig s3ClientConfig = const _i2.S3ClientConfig(),
    _i3.AWSCredentialsProvider credentialsProvider =
        const _i3.AWSCredentialsProvider.defaultChain(),
    List<_i1.HttpRequestInterceptor> requestInterceptors = const [],
    List<_i1.HttpResponseInterceptor> responseInterceptors = const [],
  }) : _region = region,
       _baseUri = baseUri,
       _s3ClientConfig = s3ClientConfig,
       _credentialsProvider = credentialsProvider,
       _requestInterceptors = requestInterceptors,
       _responseInterceptors = responseInterceptors;

  @override
  late final List<
    _i1.HttpProtocol<
      SelectObjectContentRequestPayload,
      SelectObjectContentRequest,
      SelectObjectContentEventStream,
      SelectObjectContentOutput
    >
  >
  protocols = [
    _i2.RestXmlProtocol(
      serializers: serializers,
      builderFactories: builderFactories,
      requestInterceptors:
          <_i1.HttpRequestInterceptor>[
            const _i1.WithHost(),
            const _i1.WithContentLength(),
            _i2.WithSigV4(
              region: _region,
              service: _i4.AWSService.s3,
              credentialsProvider: _credentialsProvider,
              serviceConfiguration:
                  _s3ClientConfig.signerConfiguration ??
                  _i3.S3ServiceConfiguration(),
            ),
            const _i1.WithUserAgent('aws-sdk-dart/0.3.1'),
            const _i2.WithSdkInvocationId(),
            const _i2.WithSdkRequest(),
          ] +
          _requestInterceptors,
      responseInterceptors:
          <_i1.HttpResponseInterceptor>[] + _responseInterceptors,
      noErrorWrapping: true,
    ),
  ];

  late final _i2.AWSEndpoint _awsEndpoint = endpointResolver.resolve(
    sdkId,
    _region,
  );

  final String _region;

  final Uri? _baseUri;

  final _i2.S3ClientConfig _s3ClientConfig;

  final _i3.AWSCredentialsProvider _credentialsProvider;

  final List<_i1.HttpRequestInterceptor> _requestInterceptors;

  final List<_i1.HttpResponseInterceptor> _responseInterceptors;

  @override
  _i1.HttpRequest buildRequest(SelectObjectContentRequest input) =>
      _i1.HttpRequest((b) {
        b.method = 'POST';
        b.path = _s3ClientConfig.usePathStyle
            ? r'/{Bucket}/{Key+}?select&select-type=2&x-id=SelectObjectContent'
            : r'/{Key+}?select&select-type=2&x-id=SelectObjectContent';
        b.hostPrefix = _s3ClientConfig.usePathStyle ? null : '{Bucket}.';
        if (input.sseCustomerAlgorithm != null) {
          if (input.sseCustomerAlgorithm!.isNotEmpty) {
            b.headers['x-amz-server-side-encryption-customer-algorithm'] =
                input.sseCustomerAlgorithm!;
          }
        }
        if (input.sseCustomerKey != null) {
          if (input.sseCustomerKey!.isNotEmpty) {
            b.headers['x-amz-server-side-encryption-customer-key'] =
                input.sseCustomerKey!;
          }
        }
        if (input.sseCustomerKeyMd5 != null) {
          if (input.sseCustomerKeyMd5!.isNotEmpty) {
            b.headers['x-amz-server-side-encryption-customer-key-MD5'] =
                input.sseCustomerKeyMd5!;
          }
        }
        if (input.expectedBucketOwner != null) {
          if (input.expectedBucketOwner!.isNotEmpty) {
            b.headers['x-amz-expected-bucket-owner'] =
                input.expectedBucketOwner!;
          }
        }
      });

  @override
  int successCode([SelectObjectContentOutput? output]) => 200;

  @override
  SelectObjectContentOutput buildOutput(
    SelectObjectContentEventStream? payload,
    _i4.AWSBaseHttpResponse response,
  ) => SelectObjectContentOutput.fromResponse(payload, response);

  @override
  List<_i1.SmithyError> get errorTypes => const [];

  @override
  String get runtimeTypeName => 'SelectObjectContent';

  @override
  _i2.AWSRetryer get retryer => _i2.AWSRetryer();

  @override
  Uri get baseUri {
    var baseUri = _baseUri ?? endpoint.uri;
    if (_s3ClientConfig.useDualStack) {
      baseUri = baseUri.replace(
        host: baseUri.host.replaceFirst(RegExp(r'^s3\.'), 's3.dualstack.'),
      );
    }
    if (_s3ClientConfig.useAcceleration) {
      baseUri = baseUri.replace(
        host: baseUri.host
            .replaceFirst(RegExp('$_region\\.'), '')
            .replaceFirst(RegExp(r'^s3\.'), 's3-accelerate.'),
      );
    }
    return baseUri;
  }

  @override
  _i1.Endpoint get endpoint => _awsEndpoint.endpoint;

  @override
  _i1.SmithyOperation<SelectObjectContentOutput> run(
    SelectObjectContentRequest input, {
    _i4.AWSHttpClient? client,
    _i1.ShapeId? useProtocol,
  }) {
    return _i5.runZoned(
      () => super.run(input, client: client, useProtocol: useProtocol),
      zoneValues: {
        ...?_awsEndpoint.credentialScope?.zoneValues,
        ...{_i4.AWSHeaders.sdkInvocationId: _i4.uuid(secure: true)},
      },
    );
  }
}
