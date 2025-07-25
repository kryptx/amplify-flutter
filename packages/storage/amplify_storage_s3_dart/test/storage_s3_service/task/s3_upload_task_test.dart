// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3_dart/amplify_storage_s3_dart.dart';
import 'package:amplify_storage_s3_dart/src/exception/s3_storage_exception.dart';
import 'package:amplify_storage_s3_dart/src/sdk/s3.dart' as s3;
import 'package:amplify_storage_s3_dart/src/storage_s3_service/storage_s3_service.dart';
import 'package:amplify_storage_s3_dart/src/storage_s3_service/transfer/database/transfer_record.dart';
import 'package:amplify_storage_s3_dart/src/storage_s3_service/transfer/transfer.dart'
    as transfer;
import 'package:mocktail/mocktail.dart';
import 'package:smithy/smithy.dart' as smithy;
import 'package:smithy_aws/smithy_aws.dart' as smithy_aws;
import 'package:test/test.dart';

import '../../test_utils/io_mocks.dart';
import '../../test_utils/mocks.dart';
import '../../test_utils/test_path_resolver.dart';

void main() {
  group('S3UploadTask', () {
    late s3.S3Client s3Client;
    late AWSLogger logger;
    late transfer.TransferDatabase transferDatabase;
    const testBucket = 'fake-bucket';
    const testRegion = 'test-region';
    const defaultS3ClientConfig = smithy_aws.S3ClientConfig();
    final pathResolver = TestPathResolver();
    const testUploadDataOptions = StorageUploadDataOptions();

    setUpAll(() {
      s3Client = MockS3Client();
      logger = MockAWSLogger();
      transferDatabase = MockTransferDatabase();

      registerFallbackValue(
        s3.PutObjectRequest(bucket: 'fake bucket', key: 'dummy key'),
      );
      registerFallbackValue(
        s3.HeadObjectRequest(bucket: 'fake bucket', key: 'dummy key'),
      );

      registerFallbackValue(
        s3.CreateMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
        ),
      );

      registerFallbackValue(
        s3.UploadPartRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        s3.CompleteMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        s3.AbortMultipartUploadRequest(
          bucket: 'fake bucket',
          key: 'dummy key',
          uploadId: 'uploadId',
        ),
      );

      registerFallbackValue(
        TransferRecord(
          uploadId: 'uploadId',
          objectKey: 'dummy key',
          createdAt: DateTime(2022, 1, 1),
        ),
      );

      registerFallbackValue(const smithy_aws.S3ClientConfig());
    });

    group('Uploading S3DataPayload', () {
      final testDataPayload = S3DataPayload.string('Upload me please!');
      final testDataPayloadBytes = S3DataPayload.bytes([101, 102]);
      const testPath = StoragePath.fromString('object-upload-to');

      test(
        'should invoke S3Client.putObject API with expected parameters and default access level',
        () async {
          final testPutObjectOutput = s3.PutObjectOutput();
          final smithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          when(
            () => smithyOperation.result,
          ).thenAnswer((_) async => testPutObjectOutput);
          when(
            () => smithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => smithyOperation);

          final uploadDataTask = S3UploadTask.fromDataPayload(
            testDataPayload,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: testPath,
            options: const StorageUploadDataOptions(),
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());

          final result = await uploadDataTask.result;

          expect(result.path, TestPathResolver.path);

          final capturedRequest = verify(
            () => s3Client.putObject(
              captureAny<s3.PutObjectRequest>(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).captured.last;

          expect(capturedRequest is s3.PutObjectRequest, isTrue);
          final request = capturedRequest as s3.PutObjectRequest;
          expect(request.bucket, testBucket);
          expect(request.key, TestPathResolver.path);
          expect(request.body, testDataPayload);
        },
      );

      test(
        'should invoke S3Client.putObject API with correct useAcceleration parameters',
        () async {
          const testUploadDataOptions = StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(
              useAccelerateEndpoint: true,
            ),
          );
          final testPutObjectOutput = s3.PutObjectOutput();
          final smithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          when(
            () => smithyOperation.result,
          ).thenAnswer((_) async => testPutObjectOutput);
          when(
            () => smithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => smithyOperation);

          final uploadDataTask = S3UploadTask.fromDataPayload(
            testDataPayload,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: testPath,
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());

          await uploadDataTask.result;

          final capturedS3ClientConfig = verify(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: captureAny<smithy_aws.S3ClientConfig>(
                named: 's3ClientConfig',
              ),
            ),
          ).captured.last;

          expect(
            capturedS3ClientConfig,
            isA<smithy_aws.S3ClientConfig>().having(
              (o) => o.useAcceleration,
              'useAcceleration',
              true,
            ),
          );
        },
      );

      test('should use fallback contentType header when contentType of the data'
          ' payload is not determinable', () async {
        final testPutObjectOutput = s3.PutObjectOutput();
        final smithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

        when(
          () => smithyOperation.result,
        ).thenAnswer((_) async => testPutObjectOutput);
        when(
          () => smithyOperation.requestProgress,
        ).thenAnswer((_) => Stream.value(1));
        when(
          () => s3Client.putObject(
            any(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).thenAnswer((_) => smithyOperation);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayloadBytes,
          s3Client: s3Client,
          s3ClientConfig: defaultS3ClientConfig,
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: testPath,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        await uploadDataTask.result;

        final capturedRequest = verify(
          () => s3Client.putObject(
            captureAny<s3.PutObjectRequest>(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).captured.last;

        expect(
          capturedRequest,
          isA<s3.PutObjectRequest>().having(
            (o) => o.contentType,
            'contentType',
            fallbackContentType,
          ),
        );
      });

      test(
        'should invoke S3Client.headObject API with correct parameters when getProperties is set to true in the options',
        () async {
          const testUploadDataOptions = StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(getProperties: true),
          );
          final testPutObjectOutput = s3.PutObjectOutput();
          final putSmithyOperation = MockSmithyOperation<s3.PutObjectOutput>();
          final testHeadObjectOutput = s3.HeadObjectOutput();
          final headSmithyOperation =
              MockSmithyOperation<s3.HeadObjectOutput>();

          when(
            () => putSmithyOperation.result,
          ).thenAnswer((_) async => testPutObjectOutput);
          when(
            () => putSmithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => headSmithyOperation.result,
          ).thenAnswer((_) async => testHeadObjectOutput);

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => putSmithyOperation);

          when(
            () => s3Client.headObject(any()),
          ).thenAnswer((_) => headSmithyOperation);

          final uploadDataTask = S3UploadTask.fromDataPayload(
            testDataPayload,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: testPath,
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());
          await uploadDataTask.result;

          final capturedRequest = verify(
            () => s3Client.headObject(captureAny<s3.HeadObjectRequest>()),
          ).captured.last;

          expect(capturedRequest is s3.HeadObjectRequest, isTrue);
          final request = capturedRequest as s3.HeadObjectRequest;
          expect(request.bucket, testBucket);
          expect(request.key, TestPathResolver.path);
        },
      );

      test('should throw StorageAccessDeniedException when S3Client.putObject'
          ' returned UnknownSmithyHttpException with status code 403', () {
        const testException = smithy.UnknownSmithyHttpException(
          statusCode: 403,
          body: 'Access denied!',
        );

        when(
          () => s3Client.putObject(
            any(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).thenThrow(testException);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          s3ClientConfig: defaultS3ClientConfig,
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: testPath,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        expect(
          uploadDataTask.result,
          throwsA(isA<StorageAccessDeniedException>()),
        );
      });

      test('should throw NetworkException when S3Client.putObject'
          ' returned AWSHttpException', () {
        const testUploadDataOptions = StorageUploadDataOptions();
        final testException = AWSHttpException(
          AWSHttpRequest(method: AWSHttpMethod.put, uri: Uri()),
        );

        when(
          () => s3Client.putObject(
            any(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).thenThrow(testException);

        final uploadDataTask = S3UploadTask.fromDataPayload(
          testDataPayload,
          s3Client: s3Client,
          s3ClientConfig: defaultS3ClientConfig,
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: testPath,
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadDataTask.start());

        expect(uploadDataTask.result, throwsA(isA<NetworkException>()));
      });

      test(
        'cancel() should cancel underlying put object request and throw a StorageException',
        () async {
          final putSmithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          final completer = Completer<void>();
          when(() => putSmithyOperation.result).thenAnswer((_) async {
            await completer.future;
            throw const CancellationException();
          });
          when(putSmithyOperation.cancel).thenAnswer((_) async {});
          when(
            () => putSmithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => putSmithyOperation);

          final uploadDataTask = S3UploadTask.fromDataPayload(
            testDataPayload,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: testPath,
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());
          await uploadDataTask.cancel();

          completer.complete();

          await expectLater(
            uploadDataTask.result,
            throwsA(isA<StorageException>()),
          );
          verify(putSmithyOperation.cancel).called(1);
        },
      );
    });

    group('Uploading AWSFile (<=5MB) - putObject', () {
      final testBytes = [101, 102, 103];
      final testLocalFile = AWSFile.fromStream(
        Stream.value(testBytes),
        size: testBytes.length,
        contentType: 'image/jpeg',
      );
      const testKey = 'object-upload-to';

      test(
        'should invoke S3Client.putObject with expected parameters',
        () async {
          final testPutObjectOutput = s3.PutObjectOutput();
          final smithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          when(
            () => smithyOperation.result,
          ).thenAnswer((_) async => testPutObjectOutput);
          when(
            () => smithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => smithyOperation);

          final uploadDataTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());

          final result = await uploadDataTask.result;

          expect(result.path, TestPathResolver.path);

          final capturedRequest = verify(
            () => s3Client.putObject(
              captureAny<s3.PutObjectRequest>(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).captured.last;

          expect(capturedRequest is s3.PutObjectRequest, isTrue);
          final request = capturedRequest as s3.PutObjectRequest;
          expect(request.bucket, testBucket);
          expect(request.key, TestPathResolver.path);
          expect(request.contentType, await testLocalFile.contentType);
          expect(await request.body.toList(), equals([testBytes]));
        },
      );

      test(
        'should invoke S3Client.putObject with correct useAcceleration parameter',
        () async {
          const testUploadDataOptions = StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(
              useAccelerateEndpoint: true,
            ),
          );
          final testPutObjectOutput = s3.PutObjectOutput();
          final smithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          when(
            () => smithyOperation.result,
          ).thenAnswer((_) async => testPutObjectOutput);
          when(
            () => smithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => smithyOperation);

          final uploadDataTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());

          await uploadDataTask.result;

          final capturedS3ClientConfig = verify(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: captureAny<smithy_aws.S3ClientConfig>(
                named: 's3ClientConfig',
              ),
            ),
          ).captured.last;

          expect(
            capturedS3ClientConfig,
            isA<smithy_aws.S3ClientConfig>().having(
              (o) => o.useAcceleration,
              'useAcceleration',
              true,
            ),
          );
        },
      );

      test(
        'cancel() should cancel underlying put object request and throw a StorageException',
        () async {
          final putSmithyOperation = MockSmithyOperation<s3.PutObjectOutput>();

          final completer = Completer<void>();
          when(() => putSmithyOperation.result).thenAnswer((_) async {
            await completer.future;
            throw const CancellationException();
          });
          when(putSmithyOperation.cancel).thenAnswer((_) async {});
          when(
            () => putSmithyOperation.requestProgress,
          ).thenAnswer((_) => Stream.value(1));

          when(
            () => s3Client.putObject(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => putSmithyOperation);

          final uploadDataTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadDataTask.start());
          await uploadDataTask.cancel();

          completer.complete();

          await expectLater(
            uploadDataTask.result,
            throwsA(isA<StorageException>()),
          );
          verify(putSmithyOperation.cancel).called(1);
        },
      );

      test('Emitting transferred bytes for uploading progress', () async {
        const mockEmittedBytes = [1, 2, 3];
        final completer = Completer<void>();
        final putSmithyOperation = MockSmithyOperation<s3.PutObjectOutput>();
        final testPutObjectOutput = s3.PutObjectOutput();
        when(() => putSmithyOperation.result).thenAnswer((_) async {
          await completer.future;
          return testPutObjectOutput;
        });
        when(putSmithyOperation.cancel).thenAnswer((_) async {});
        when(() => putSmithyOperation.requestProgress).thenAnswer((_) async* {
          for (final num in mockEmittedBytes) {
            yield num;
          }
          completer.complete();
        });

        when(
          () => s3Client.putObject(
            any(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).thenAnswer((_) => putSmithyOperation);

        final emittedTransferredBytes = <int>[];

        final uploadDataTask = S3UploadTask.fromAWSFile(
          testLocalFile,
          s3Client: s3Client,
          s3ClientConfig: defaultS3ClientConfig,
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: const StoragePath.fromString(testKey),
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
          onProgress: (event) {
            emittedTransferredBytes.add(event.transferredBytes);
          },
        );
        unawaited(uploadDataTask.start());
        await uploadDataTask.result;
        expect(emittedTransferredBytes, containsAllInOrder(mockEmittedBytes));
      });
    });

    group('Uploading AWSFile (> 5MB)', () {
      final testBytes = Uint8List(11 * 1024 * 1024); // 11MB
      late Stream<List<int>> testFileReadStream;
      late AWSFile testLocalFile;
      const testKey = 'object-upload-to';

      setUp(() {
        testFileReadStream = _getBytesStream(testBytes);
        testLocalFile = AWSFile.fromStream(
          testFileReadStream,
          size: testBytes.length,
          contentType: 'image/png',
        );
      });

      test(
        'should invoke corresponding S3Client APIs with in a happy path to complete the upload',
        () async {
          final receivedState = <StorageTransferState>[];
          void onProgress(S3TransferProgress progress) {
            receivedState.add(progress.state);
          }

          const testUploadDataOptions = StorageUploadDataOptions(
            metadata: {'filename': 'png.png'},
            pluginOptions: S3UploadDataPluginOptions(getProperties: true),
          );
          const testMultipartUploadId = 'awesome-upload';

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: testMultipartUploadId);
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any<TransferRecord>()),
          ).thenAnswer((_) async => '1');

          final testUploadPartOutput1 = s3.UploadPartOutput(
            eTag: 'eTag-part-1',
          );
          final testUploadPartOutput2 = s3.UploadPartOutput(
            eTag: 'eTag-part-2',
          );
          final testUploadPartOutput3 = s3.UploadPartOutput(
            eTag: 'eTag-part-3',
          );
          final uploadPartSmithyOperation1 =
              MockSmithyOperation<s3.UploadPartOutput>();
          final uploadPartSmithyOperation2 =
              MockSmithyOperation<s3.UploadPartOutput>();
          final uploadPartSmithyOperation3 =
              MockSmithyOperation<s3.UploadPartOutput>();

          when(
            () => uploadPartSmithyOperation1.result,
          ).thenAnswer((_) async => testUploadPartOutput1);
          when(
            () => uploadPartSmithyOperation2.result,
          ).thenAnswer((_) async => testUploadPartOutput2);
          when(
            () => uploadPartSmithyOperation3.result,
          ).thenAnswer((_) async => testUploadPartOutput3);

          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((invocation) {
            final request =
                invocation.positionalArguments.first as s3.UploadPartRequest;

            switch (request.partNumber) {
              case 1:
                return uploadPartSmithyOperation1;
              case 2:
                return uploadPartSmithyOperation2;
              case 3:
                return uploadPartSmithyOperation3;
            }

            throw Exception('this is not going to happen in this test setup');
          });

          final testCompleteMultipartUploadOutput =
              s3.CompleteMultipartUploadOutput();
          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();

          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);

          final testHeadObjectOutput = s3.HeadObjectOutput();
          final headSmithyOperation =
              MockSmithyOperation<s3.HeadObjectOutput>();

          when(
            () => headSmithyOperation.result,
          ).thenAnswer((_) async => testHeadObjectOutput);

          when(
            () => s3Client.headObject(any()),
          ).thenAnswer((_) => headSmithyOperation);

          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: onProgress,
          );

          unawaited(uploadTask.start());

          await uploadTask.result;

          // verify generated CreateMultipartUploadRequest
          final capturedCreateMultipartUploadRequest = verify(
            () => s3Client.createMultipartUpload(
              captureAny<s3.CreateMultipartUploadRequest>(),
            ),
          ).captured.last;
          expect(
            capturedCreateMultipartUploadRequest,
            isA<s3.CreateMultipartUploadRequest>(),
          );
          final createMultipartUploadRequest =
              capturedCreateMultipartUploadRequest
                  as s3.CreateMultipartUploadRequest;
          expect(createMultipartUploadRequest.bucket, testBucket);
          expect(
            createMultipartUploadRequest.contentType,
            await testLocalFile.contentType,
          );
          expect(createMultipartUploadRequest.key, TestPathResolver.path);
          expect(
            capturedCreateMultipartUploadRequest.metadata?['filename'],
            testUploadDataOptions.metadata['filename'],
          );
          final capturedTransferDBInsertParam = verify(
            () => transferDatabase.insertTransferRecord(
              captureAny<TransferRecord>(),
            ),
          ).captured.last;
          expect(
            capturedTransferDBInsertParam,
            isA<TransferRecord>().having(
              (o) => o.uploadId,
              'uploadId',
              testMultipartUploadId,
            ),
          );

          // verify uploadPart calls
          final uploadPartVerification = verify(
            () => s3Client.uploadPart(
              captureAny<s3.UploadPartRequest>(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          )..called(3); // 11MB file creates 3 upload part requests
          final capturedUploadPartRequests = uploadPartVerification.captured;
          final partNumbers = <int>[];
          final bytes = BytesBuilder();

          await Future.forEach(capturedUploadPartRequests, (
            capturedRequest,
          ) async {
            expect(capturedRequest, isA<s3.UploadPartRequest>());
            final request = capturedRequest as s3.UploadPartRequest;
            expect(request.bucket, testBucket);
            expect(request.key, TestPathResolver.path);
            partNumbers.add(request.partNumber!);
            bytes.add(
              await request.body.toList().then(
                (collectedBytes) =>
                    collectedBytes.expand((bytes) => bytes).toList(),
              ),
            );
          });
          expect(bytes.takeBytes(), equals(testBytes));
          expect(partNumbers, equals([1, 2, 3]));
          expect(
            receivedState,
            List.generate(4, (_) => StorageTransferState.inProgress)
              ..add(StorageTransferState.success),
          ); // upload start + 3 parts

          // verify the CompleteMultipartUpload request
          final capturedCompleteMultipartUploadRequest = verify(
            () => s3Client.completeMultipartUpload(
              captureAny<s3.CompleteMultipartUploadRequest>(),
            ),
          ).captured.last;
          expect(
            capturedCompleteMultipartUploadRequest,
            isA<s3.CompleteMultipartUploadRequest>(),
          );
          final completeMultipartUploadRequest =
              capturedCompleteMultipartUploadRequest
                  as s3.CompleteMultipartUploadRequest;
          expect(completeMultipartUploadRequest.bucket, testBucket);
          expect(completeMultipartUploadRequest.key, TestPathResolver.path);

          final capturedTransferDBDeleteParam = verify(
            () => transferDatabase.deleteTransferRecords(captureAny()),
          ).captured.last;
          expect(capturedTransferDBDeleteParam, testMultipartUploadId);
        },
      );

      test(
        'should invoke S3Client uploadPart API with correct useAcceleration parameter',
        () async {
          const testUploadDataOptions = StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(
              useAccelerateEndpoint: true,
            ),
          );

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: '123');
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag');
          final uploadPartSmithyOperation =
              MockSmithyOperation<s3.UploadPartOutput>();

          when(
            () => uploadPartSmithyOperation.result,
          ).thenAnswer((_) async => testUploadPartOutput);

          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => uploadPartSmithyOperation);

          final testCompleteMultipartUploadOutput =
              s3.CompleteMultipartUploadOutput();
          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();

          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);

          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
          );

          unawaited(uploadTask.start());

          await uploadTask.result;

          // verify uploadPart calls
          final uploadPartVerification = verify(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: captureAny<smithy_aws.S3ClientConfig>(
                named: 's3ClientConfig',
              ),
            ),
          )..called(3); // 11MB file creates 3 upload part requests

          final capturedS3ClientConfigs = uploadPartVerification.captured;

          for (final s3ClientConfig in capturedS3ClientConfigs) {
            expect(
              s3ClientConfig,
              isA<smithy_aws.S3ClientConfig>().having(
                (o) => o.useAcceleration,
                'useAcceleration',
                true,
              ),
            );
          }
        },
      );

      test('should use fallback contentType header when contentType of the data'
          ' payload is not determinable', () async {
        final testLocalFileWithoutContentType = AWSFile.fromData(testBytes);
        const testMultipartUploadId = 'awesome-upload';

        final testCreateMultipartUploadOutput = s3.CreateMultipartUploadOutput(
          uploadId: testMultipartUploadId,
        );
        final createMultipartUploadSmithyOperation =
            MockSmithyOperation<s3.CreateMultipartUploadOutput>();

        when(
          () => createMultipartUploadSmithyOperation.result,
        ).thenAnswer((_) async => testCreateMultipartUploadOutput);

        when(
          () => s3Client.createMultipartUpload(any()),
        ).thenAnswer((_) => createMultipartUploadSmithyOperation);

        when(
          () => transferDatabase.insertTransferRecord(any()),
        ).thenAnswer((_) async => '1');

        final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag-part-1');
        final uploadPartSmithyOperation =
            MockSmithyOperation<s3.UploadPartOutput>();

        when(
          () => uploadPartSmithyOperation.result,
        ).thenAnswer((_) async => testUploadPartOutput);

        when(
          () => s3Client.uploadPart(
            any(),
            s3ClientConfig: any(named: 's3ClientConfig'),
          ),
        ).thenAnswer((invocation) => uploadPartSmithyOperation);

        final testCompleteMultipartUploadOutput =
            s3.CompleteMultipartUploadOutput();
        final completeMultipartUploadSmithyOperation =
            MockSmithyOperation<s3.CompleteMultipartUploadOutput>();

        when(
          () => completeMultipartUploadSmithyOperation.result,
        ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

        when(
          () => s3Client.completeMultipartUpload(any()),
        ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

        when(
          () => transferDatabase.deleteTransferRecords(any()),
        ).thenAnswer((_) async => 1);

        final uploadTask = S3UploadTask.fromAWSFile(
          testLocalFileWithoutContentType,
          s3Client: s3Client,
          s3ClientConfig: defaultS3ClientConfig,
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: const StoragePath.fromString(testKey),
          options: testUploadDataOptions,
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadTask.start());

        await uploadTask.result;

        // verify generated CreateMultipartUploadRequest
        final capturedCreateMultipartUploadRequest = verify(
          () => s3Client.createMultipartUpload(
            captureAny<s3.CreateMultipartUploadRequest>(),
          ),
        ).captured.last;
        expect(
          capturedCreateMultipartUploadRequest,
          isA<s3.CreateMultipartUploadRequest>().having(
            (o) => o.contentType,
            'contentType',
            fallbackContentType,
          ),
        );
      });

      group('when AWSFile is backed by', () {
        late AWSFile testLocalFile;

        setUpAll(() {
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();
          when(() => createMultipartUploadSmithyOperation.result).thenAnswer(
            (_) async => s3.CreateMultipartUploadOutput(uploadId: '123'),
          );
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);
          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final uploadPartSmithyOperation =
              MockSmithyOperation<s3.UploadPartOutput>();
          when(
            () => uploadPartSmithyOperation.result,
          ).thenAnswer((_) async => s3.UploadPartOutput(eTag: 'eTag'));
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => uploadPartSmithyOperation);

          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();

          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => s3.CompleteMultipartUploadOutput());
          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);
        });

        setUp(() {
          testLocalFile = MockAWSFile();

          when(
            () => testLocalFile.contentType,
          ).thenAnswer((_) async => 'image/jpg');
        });

        test(
          'stream, should invoke AWSFile.getChunkedStreamReader reading chunks',
          () async {
            final mockChunkedStreamReader = MockChunkedStreamReader();
            // file is backed by stream
            when(
              () => testLocalFile.openRead(any(), any()),
            ).thenThrow(const InvalidFileException());
            when(() => testLocalFile.size).thenAnswer(
              (invocation) async => 11 * 1024 * 1024, // 11MiB
            );
            when(
              testLocalFile.getChunkedStreamReader,
            ).thenAnswer((invocation) => mockChunkedStreamReader);
            when(
              () => mockChunkedStreamReader.readChunk(any()),
            ).thenAnswer((invocation) async => [1]);

            final uploadTask = S3UploadTask.fromAWSFile(
              testLocalFile,
              s3Client: s3Client,
              s3ClientConfig: defaultS3ClientConfig,
              pathResolver: pathResolver,
              bucket: testBucket,
              awsRegion: testRegion,
              path: const StoragePath.fromString(testKey),
              options: testUploadDataOptions,
              logger: logger,
              transferDatabase: transferDatabase,
            );

            unawaited(uploadTask.start());
            await uploadTask.result;

            verify(() => testLocalFile.openRead(any(), any())).called(
              1, // 1 call to check if the file is backed by a platform file
            );
            verify(testLocalFile.getChunkedStreamReader).called(1);
            verify(
              () => mockChunkedStreamReader.readChunk(any()),
            ).called(3); // 3 parts => 3 reads
            verifyNever(testLocalFile.openRead);
          },
        );

        test(
          'platform file, should invoke AWSFile.openRead reading chunks',
          () async {
            // file is backed by platform File
            when(
              () => testLocalFile.openRead(any(), any()),
            ).thenAnswer((invocation) => Stream.value([1]));
            when(() => testLocalFile.size).thenAnswer(
              (invocation) async => 11 * 1024 * 1024, // 11MiB
            );

            final uploadTask = S3UploadTask.fromAWSFile(
              testLocalFile,
              s3Client: s3Client,
              s3ClientConfig: defaultS3ClientConfig,
              pathResolver: pathResolver,
              bucket: testBucket,
              awsRegion: testRegion,
              path: const StoragePath.fromString(testKey),
              options: testUploadDataOptions,
              logger: logger,
              transferDatabase: transferDatabase,
            );

            unawaited(uploadTask.start());
            await uploadTask.result;

            verify(() => testLocalFile.openRead(any(), any())).called(
              1 // 1 call to check if the file is backed by a platform file
                  +
                  3, // 3 calls to read the chunks,
            );
          },
        );
      });

      test(
        'should throw exception if the file to be upload is too large to initiate a multipart upload',
        () async {
          late StorageTransferState finalState;
          final testBadFile = AWSFile.fromStream(
            Stream.value([]),
            size: 5 * 1024 * 1024 * 1024 * 1024 + 1, // > 5TiB
          );
          final uploadTask = S3UploadTask.fromAWSFile(
            testBadFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          unawaited(uploadTask.start());

          await expectLater(
            uploadTask.result,
            throwsA(isA<StorageException>()),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should handle async gaps when reading from Multipart file',
        () async {
          late StorageTransferState finalState;

          //completeMultipartUploadSmithyOperation
          final testCompleteMultipartUploadOutput =
              s3.CompleteMultipartUploadOutput();
          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();
          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCompleteMultipartUploadOutput);

          //uploadPartSmithyOperation
          final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag-part-1');
          final uploadPartSmithyOperation =
              MockSmithyOperation<s3.UploadPartOutput>();
          when(
            () => uploadPartSmithyOperation.result,
          ).thenAnswer((_) async => testUploadPartOutput);

          //createMultipartUploadSmithyOperation
          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(
                uploadId:
                    'uploadId', // response should always contain valid uploadId
              );
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();
          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          //s3Client
          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => uploadPartSmithyOperation);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          //transferDatabase
          when(
            () => transferDatabase.insertTransferRecord(any<TransferRecord>()),
          ).thenAnswer((_) async => '1');
          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);

          final bytes = List<int>.filled((32 * pow(2, 20)).toInt(), 0);
          final mockFile = AWSFile.fromStream(
            Stream.value(bytes),
            size: bytes.length,
            contentType: 'image/jpeg',
          );

          final uploadTask = S3UploadTask.fromAWSFile(
            mockFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          unawaited(uploadTask.start());

          await uploadTask.result;

          expect(finalState, StorageTransferState.success);
        },
      );

      test(
        'should complete with StorageAccessDeniedException when CreateMultipartUploadRequest'
        ' returned UnknownSmithyHttpException with status code 403',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          const testException = smithy.UnknownSmithyHttpException(
            statusCode: 403,
            body: 'Access denied!',
          );

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenThrow(testException);

          unawaited(uploadTask.start());

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<StorageAccessDeniedException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
            ),
          );

          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should complete with NetworkException when CreateMultipartUploadRequest'
        ' returned AWSHttpException',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: const StorageUploadDataOptions(),
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          final testException = AWSHttpException(
            AWSHttpRequest(method: AWSHttpMethod.post, uri: Uri()),
          );

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenThrow(testException);

          unawaited(uploadTask.start());

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<NetworkException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
            ),
          );

          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should complete with error when CreateMultipartUploadRequest does NOT return a valid uploadId',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(
                uploadId: null, // response should always contain valid uploadId
              );
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          unawaited(uploadTask.start());

          await expectLater(
            uploadTask.result,
            throwsA(isA<StorageException>()),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should complete with StorageAccessDeniedException when'
        ' CompleteMultipartUploadRequest fails (should not happen just in case)',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: 'some-upload-id');
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);

          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final testUploadPartOutput = s3.UploadPartOutput(eTag: 'eTag-part-1');
          final uploadPartSmithyOperation =
              MockSmithyOperation<s3.UploadPartOutput>();

          when(
            () => uploadPartSmithyOperation.result,
          ).thenAnswer((_) async => testUploadPartOutput);

          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => uploadPartSmithyOperation);

          const testException = smithy.UnknownSmithyHttpException(
            statusCode: 403,
            body: 'Access denied!',
          );
          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();

          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenThrow(testException);
          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

          unawaited(uploadTask.start());

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<StorageAccessDeniedException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
            ),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should terminate multipart upload when a UploadPartRequest fails due to 403'
        ' and should complete with StorageAccessDeniedException',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );
          const testMultipartUploadId = 'some-upload-id';

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: testMultipartUploadId);
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          const testException = smithy.UnknownSmithyHttpException(
            statusCode: 403,
            body: 'Access denied!',
          );
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenThrow(testException);

          unawaited(uploadTask.start());

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          final abortMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.AbortMultipartUploadOutput>();
          when(
            () => abortMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) => abortMultipartUploadSmithyOperation);

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<StorageException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                isA<StorageAccessDeniedException>().having(
                  (o) => o.underlyingException,
                  'underlyingException',
                  testException,
                ),
              ),
            ),
          );

          final capturedAbortMultipartUploadRequest = verify(
            () => s3Client.abortMultipartUpload(
              captureAny<s3.AbortMultipartUploadRequest>(),
            ),
          ).captured.last;

          expect(
            capturedAbortMultipartUploadRequest,
            isA<s3.AbortMultipartUploadRequest>().having(
              (o) => o.uploadId,
              'uploadId',
              testMultipartUploadId,
            ),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should terminate multipart upload when a UploadPartRequest fails due to AWSHttpException'
        ' and should complete with NetworkException',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: const StorageUploadDataOptions(),
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );
          const testMultipartUploadId = 'some-upload-id';

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: testMultipartUploadId);
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();

          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final testException = AWSHttpException(
            AWSHttpRequest(method: AWSHttpMethod.put, uri: Uri()),
          );
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenThrow(testException);

          unawaited(uploadTask.start());

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          final abortMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.AbortMultipartUploadOutput>();
          when(
            () => abortMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) => abortMultipartUploadSmithyOperation);

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<StorageException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                isA<NetworkException>().having(
                  (o) => o.underlyingException,
                  'underlyingException',
                  testException,
                ),
              ),
            ),
          );

          final capturedAbortMultipartUploadRequest = verify(
            () => s3Client.abortMultipartUpload(
              captureAny<s3.AbortMultipartUploadRequest>(),
            ),
          ).captured.last;

          expect(
            capturedAbortMultipartUploadRequest,
            isA<s3.AbortMultipartUploadRequest>().having(
              (o) => o.uploadId,
              'uploadId',
              testMultipartUploadId,
            ),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should terminate multipart upload when a UploadPartRequest does NOT return a valid eTag and complete with error',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );
          const testMultipartUploadId = 'some-upload-id';

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: testMultipartUploadId);
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();
          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final testUploadPartOutput = s3.UploadPartOutput(eTag: null);
          final uploadPartSmithyOperation =
              MockSmithyOperation<s3.UploadPartOutput>();

          when(
            () => uploadPartSmithyOperation.result,
          ).thenAnswer((_) async => testUploadPartOutput);
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((_) => uploadPartSmithyOperation);

          unawaited(uploadTask.start());

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          final abortMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.AbortMultipartUploadOutput>();
          when(
            () => abortMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) => abortMultipartUploadSmithyOperation);

          await expectLater(
            uploadTask.result,
            throwsA(isA<StorageException>()),
          );

          expect(finalState, StorageTransferState.failure);
        },
      );

      test(
        'should terminate multipart upload when a UploadPartRequest encountered NoSuchUpload error and complete with error',
        () async {
          late StorageTransferState finalState;
          final uploadTask = S3UploadTask.fromAWSFile(
            testLocalFile,
            s3Client: s3Client,
            s3ClientConfig: defaultS3ClientConfig,
            pathResolver: pathResolver,
            bucket: testBucket,
            awsRegion: testRegion,
            path: const StoragePath.fromString(testKey),
            options: testUploadDataOptions,
            logger: logger,
            transferDatabase: transferDatabase,
            onProgress: (progress) {
              finalState = progress.state;
            },
          );
          const testMultipartUploadId = 'some-upload-id';

          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: testMultipartUploadId);
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();
          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          final testException = s3.NoSuchUpload();
          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenThrow(testException);

          unawaited(uploadTask.start());

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          final abortMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.AbortMultipartUploadOutput>();
          when(
            () => abortMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) => abortMultipartUploadSmithyOperation);

          await expectLater(
            uploadTask.result,
            throwsA(
              isA<UnknownException>().having(
                (o) => o.underlyingException,
                'underlyingException',
                testException,
              ),
            ),
          );
          expect(finalState, StorageTransferState.failure);
        },
      );

      group('Control APIs', () {
        final testLocalFile = AWSFile.fromData(testBytes);
        final testUploadPartOutput1 = s3.UploadPartOutput(eTag: 'eTag-part-1');
        final testUploadPartOutput2 = s3.UploadPartOutput(eTag: 'eTag-part-2');
        final testUploadPartOutput3 = s3.UploadPartOutput(eTag: 'eTag-part-3');
        final uploadPartSmithyOperation1 =
            MockSmithyOperation<s3.UploadPartOutput>();
        final uploadPartSmithyOperation2 =
            MockSmithyOperation<s3.UploadPartOutput>();
        final uploadPartSmithyOperation3 =
            MockSmithyOperation<s3.UploadPartOutput>();

        setUpAll(() {
          final testCreateMultipartUploadOutput =
              s3.CreateMultipartUploadOutput(uploadId: 'some-upload-id');
          final createMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CreateMultipartUploadOutput>();
          when(
            () => createMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCreateMultipartUploadOutput);
          when(
            () => s3Client.createMultipartUpload(any()),
          ).thenAnswer((_) => createMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.insertTransferRecord(any()),
          ).thenAnswer((_) async => '1');

          when(uploadPartSmithyOperation1.cancel).thenAnswer((_) async {});
          when(uploadPartSmithyOperation2.cancel).thenAnswer((_) async {});
          when(uploadPartSmithyOperation3.cancel).thenAnswer((_) async {});

          when(
            () => s3Client.uploadPart(
              any(),
              s3ClientConfig: any(named: 's3ClientConfig'),
            ),
          ).thenAnswer((invocation) {
            final request =
                invocation.positionalArguments.first as s3.UploadPartRequest;

            switch (request.partNumber) {
              case 1:
                return uploadPartSmithyOperation1;
              case 2:
                return uploadPartSmithyOperation2;
              case 3:
                return uploadPartSmithyOperation3;
            }

            throw Exception('this should not happen in this test');
          });

          final testCompleteMultipartUploadOutput =
              s3.CompleteMultipartUploadOutput();
          final completeMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.CompleteMultipartUploadOutput>();
          when(
            () => completeMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testCompleteMultipartUploadOutput);
          when(
            () => s3Client.completeMultipartUpload(any()),
          ).thenAnswer((_) => completeMultipartUploadSmithyOperation);

          when(
            () => transferDatabase.deleteTransferRecords(any()),
          ).thenAnswer((_) async => 1);

          final testAbortMultipartUploadOutput =
              s3.AbortMultipartUploadOutput();
          final abortMultipartUploadSmithyOperation =
              MockSmithyOperation<s3.AbortMultipartUploadOutput>();
          when(
            () => abortMultipartUploadSmithyOperation.result,
          ).thenAnswer((_) async => testAbortMultipartUploadOutput);
          when(
            () => s3Client.abortMultipartUpload(any()),
          ).thenAnswer((_) => abortMultipartUploadSmithyOperation);
        });

        test(
          'pause()/resume() should emit paused stat and complete the upload',
          () async {
            final receivedState = <StorageTransferState>[];
            final uploadTask = S3UploadTask.fromAWSFile(
              testLocalFile,
              s3Client: s3Client,
              s3ClientConfig: defaultS3ClientConfig,
              pathResolver: pathResolver,
              bucket: testBucket,
              awsRegion: testRegion,
              path: const StoragePath.fromString(testKey),
              options: testUploadDataOptions,
              logger: logger,
              transferDatabase: transferDatabase,
              onProgress: (progress) {
                receivedState.add(progress.state);
              },
            );

            when(
              () => uploadPartSmithyOperation1.result,
            ).thenThrow(const CancellationException());
            when(
              () => uploadPartSmithyOperation2.result,
            ).thenThrow(const CancellationException());
            when(
              () => uploadPartSmithyOperation3.result,
            ).thenThrow(const CancellationException());

            unawaited(uploadTask.start());

            await uploadTask.pause();

            when(
              () => uploadPartSmithyOperation1.result,
            ).thenAnswer((_) async => testUploadPartOutput1);
            when(
              () => uploadPartSmithyOperation2.result,
            ).thenAnswer((_) async => testUploadPartOutput2);
            when(
              () => uploadPartSmithyOperation3.result,
            ).thenAnswer((_) async => testUploadPartOutput3);

            // add a manual delay to avoid ignoring pause state on back to back calls
            await Future<void>.delayed(const Duration(microseconds: 500));
            await uploadTask.resume();

            await uploadTask.result;
            expect(receivedState, contains(StorageTransferState.paused));

            verify(uploadPartSmithyOperation1.cancel).called(1);
            verify(uploadPartSmithyOperation2.cancel).called(1);
            verify(uploadPartSmithyOperation3.cancel).called(1);
          },
        );

        test(
          'cancel() should terminate ongoing multipart upload and throw a StorageException',
          () async {
            final receivedState = <StorageTransferState>[];
            final uploadTask = S3UploadTask.fromAWSFile(
              testLocalFile,
              s3Client: s3Client,
              s3ClientConfig: defaultS3ClientConfig,
              pathResolver: pathResolver,
              bucket: testBucket,
              awsRegion: testRegion,
              path: const StoragePath.fromString(testKey),
              options: testUploadDataOptions,
              logger: logger,
              transferDatabase: transferDatabase,
              onProgress: (progress) {
                receivedState.add(progress.state);
              },
            );

            final completer1 = Completer<void>();
            final completer2 = Completer<void>();
            final completer3 = Completer<void>();

            when(() => uploadPartSmithyOperation1.result).thenAnswer((_) async {
              await completer1.future;
              throw const CancellationException();
            });
            when(() => uploadPartSmithyOperation2.result).thenAnswer((_) async {
              await completer2.future;
              throw const CancellationException();
            });
            when(() => uploadPartSmithyOperation3.result).thenAnswer((_) async {
              await completer3.future;
              throw const CancellationException();
            });

            await uploadTask.start();

            // add a manual delay to ensure upload parts are scheduled before
            // canceling
            await Future<void>.delayed(const Duration(milliseconds: 500));
            await uploadTask.cancel();

            completer1.complete();
            completer2.complete();
            completer3.complete();

            await expectLater(
              uploadTask.result,
              throwsA(isA<StorageOperationCanceledException>()),
            );

            verify(uploadPartSmithyOperation1.cancel).called(1);
            verify(uploadPartSmithyOperation2.cancel).called(1);
            verify(uploadPartSmithyOperation3.cancel).called(1);
          },
        );
      });
    });

    group('path style URL', () {
      const testKey = 'object-upload-to';
      test('throw exception when attempt to use accelerate endpoint', () {
        final uploadTask = S3UploadTask.fromAWSFile(
          AWSFile.fromPath('fake/file.jpg'),
          s3Client: s3Client,
          s3ClientConfig: const smithy_aws.S3ClientConfig(usePathStyle: true),
          pathResolver: pathResolver,
          bucket: testBucket,
          awsRegion: testRegion,
          path: const StoragePath.fromString(testKey),
          options: const StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(
              useAccelerateEndpoint: true,
            ),
          ),
          logger: logger,
          transferDatabase: transferDatabase,
        );

        unawaited(uploadTask.start());

        expect(uploadTask.result, throwsA(accelerateEndpointUnusable));
      });
    });
  });
}

Stream<List<int>> _getBytesStream(Uint8List bytes) async* {
  const chunkSize = 64 * 1024;
  var currentPosition = 0;
  while (currentPosition < bytes.length) {
    final readRange = currentPosition + chunkSize > bytes.length
        ? bytes.length
        : currentPosition + chunkSize;
    yield bytes.sublist(currentPosition, readRange);
    currentPosition += chunkSize;
  }
}
