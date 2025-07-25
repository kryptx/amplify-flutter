// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';

import 'package:amplify_api_dart/amplify_api_dart.dart';
import 'package:amplify_api_dart/src/graphql/helpers/graphql_response_decoder.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:test/test.dart';

import 'test_models/ModelProvider.dart';
import 'util.dart';

const _exampleApiName = 'myApi456';
const _exampleHeaders = {'testKey': 'testVal'};

// Local variable types used as a type check.
// ignore_for_file: omit_local_variable_types

class MockAmplifyAPI extends AmplifyAPIDart {
  MockAmplifyAPI({super.options});

  @override
  void registerAuthProvider(APIAuthProvider authProvider) {}

  @override
  // ignore: must_call_super
  Future<void> addPlugin({
    required AmplifyAuthProviderRepository authProviderRepo,
  }) async {}
}

GraphQLResponse<T> _decodeResponseData<T>(
  GraphQLRequest<T> request,
  String data,
) {
  final serverResponse = {'data': json.decode(data)};
  return GraphQLResponseDecoder.instance.decode<T>(
    request: request,
    response: serverResponse,
  );
}

void main() {
  group('with ModelProvider', () {
    setUpAll(() async {
      await Amplify.reset();
      await Amplify.addPlugin(
        // needed to fetch the schema from within the helper
        MockAmplifyAPI(
          options: APIPluginOptions(modelProvider: ModelProvider.instance),
        ),
      );
    });
    const blogSelectionSet = 'id name createdAt updatedAt';

    group('ModelQueries', () {
      test('ModelQueries.get() should build a valid request', () {
        final id = uuid();
        final blog = Blog(id: id, name: 'Lorem ipsum $id');
        const expected =
            'query getBlog(\$id: ID!) { getBlog(id: \$id) { $blogSelectionSet } }';

        final GraphQLRequest<Blog> req = ModelQueries.get<Blog>(
          Blog.classType,
          blog.modelIdentifier,
        );

        expect(req.document, expected);
        expect(deepEquals(req.variables, {'id': id}), isTrue);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'getBlog');
      });

      test(
        'ModelQueries.get() should support additional request parameters',
        () {
          final id = uuid();
          final blog = Blog(id: id, name: 'Lorem ipsum $id');
          final req = ModelQueries.get(
            Blog.classType,
            blog.modelIdentifier,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test(
        'ModelQueries.get() returns a GraphQLRequest<Blog> when provided a modelType',
        () async {
          final id = uuid();
          final blog = Blog(id: id, name: 'Lorem ipsum $id');
          final GraphQLRequest<Blog> req = ModelQueries.get<Blog>(
            Blog.classType,
            blog.modelIdentifier,
          );
          final String data =
              '''{
        "getBlog": {
            "createdAt": "2021-01-01T01:00:00.000000000Z",
            "id": "$id",
            "name": "TestAppBlog"
        }
    }''';

          final GraphQLResponse<Blog> response = _decodeResponseData(req, data);

          expect(response.data, isA<Blog>());
          expect(response.data?.id, id);
        },
      );

      test('ModelQueries.list() should build a valid request', () async {
        const expected =
            'query listBlogs(\$filter: ModelBlogFilterInput, \$limit: Int, \$nextToken: String) { listBlogs(filter: \$filter, limit: \$limit, nextToken: \$nextToken) { items { $blogSelectionSet } nextToken } }';

        final GraphQLRequest<PaginatedResult<Blog>> req =
            ModelQueries.list<Blog>(Blog.classType);

        expect(req.document, expected);
        expect(req.modelType, isA<PaginatedModelType<Blog>>());
        expect(req.decodePath, 'listBlogs');
      });

      test(
        'ModelQueries.list() should build a valid request with pagination',
        () async {
          const expected =
              'query listBlogs(\$filter: ModelBlogFilterInput, \$limit: Int, \$nextToken: String) { listBlogs(filter: \$filter, limit: \$limit, nextToken: \$nextToken) { items { $blogSelectionSet } nextToken } }';

          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(Blog.classType, limit: 1);

          expect(req.document, expected);
          expect(req.modelType, isA<PaginatedModelType<Blog>>());
          expect(req.variables['limit'], 1);
          expect(req.decodePath, 'listBlogs');
        },
      );

      test(
        'ModelQueries.get() returns a GraphQLRequest<String> when not provided a modelType',
        () async {
          final id = uuid();
          const doc = '''query MyQuery {
      getBlog {
        id
        name
        createdAt
      }
    }''';
          final GraphQLRequest<String> req = GraphQLRequest(
            document: doc,
            variables: <String, String>{id: id},
          );
          final String data =
              '''{
        "getBlog": {
            "createdAt": "2021-01-01T01:00:00.000000000Z",
            "id": "$id",
            "name": "TestAppBlog"
        }
    }''';

          final GraphQLResponse<String> response = _decodeResponseData(
            req,
            data,
          );

          expect(response.data, isA<String>());
        },
      );

      test(
        'ModelQueries.list() returns a GraphQLRequest<PaginatedResult<Blog>> when provided a modelType',
        () async {
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(Blog.classType, limit: 2);

          const data = '''{
          "listBlogs": {
              "items": [
                {
                  "id": "test-id-1",
                  "name": "Test Blog 1",
                  "createdAt": "2021-07-29T23:09:58.441Z"
                },
                {
                  "id": "test-id-2",
                  "name": "Test Blog 2",
                  "createdAt": "2021-08-03T16:39:18.651Z"
                }
              ],
              "nextToken": "super-secret-next-token"
            }
        }''';

          final GraphQLResponse<PaginatedResult<Blog>> response =
              _decodeResponseData(req, data);

          expect(response.data, isA<PaginatedResult<Blog>>());
          expect(response.data?.items, isA<List<Blog?>>());
          expect(response.data?.items.length, 2);
        },
      );

      test(
        'ModelQueries.list() should decode gracefully when there is a null in the items list',
        () async {
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(Blog.classType, limit: 2);

          const data = '''{
          "listBlogs": {
              "items": [
                {
                  "id": "test-id-1",
                  "name": "Test Blog 1",
                  "createdAt": "2021-07-29T23:09:58.441Z"
                },
                null
              ],
              "nextToken": "super-secret-next-token"
            }
        }''';

          final GraphQLResponse<PaginatedResult<Blog>> response =
              _decodeResponseData(req, data);

          expect(response.data, isA<PaginatedResult<Blog>>());
          expect(response.data?.items, isA<List<Blog?>>());
          expect(response.data?.items.length, 2);
          expect(response.data?.items[1], isNull);
        },
      );

      test(
        'GraphQLResponse<PaginatedResult<Blog>> can get the request for next page of data',
        () async {
          const limit = 2;
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(
                Blog.classType,
                limit: limit,
                authorizationMode: APIAuthorizationType.iam,
              );

          const data = '''{
          "listBlogs": {
              "items": [
                {
                  "id": "test-id-1",
                  "name": "Test Blog 1",
                  "createdAt": "2021-07-29T23:09:58.441Z"
                },
                {
                  "id": "test-id-2",
                  "name": "Test Blog 2",
                  "createdAt": "2021-08-03T16:39:18.651Z"
                }
              ],
              "nextToken": "super-secret-next-token"
            }
        }''';

          final GraphQLResponse<PaginatedResult<Blog>> response =
              _decodeResponseData(req, data);
          expect(response.data?.hasNextResult, true);
          const expectedDocument =
              'query listBlogs(\$filter: ModelBlogFilterInput, \$limit: Int, \$nextToken: String) { listBlogs(filter: \$filter, limit: \$limit, nextToken: \$nextToken) { items { $blogSelectionSet } nextToken } }';
          final resultRequest = response.data?.requestForNextResult;
          expect(resultRequest?.document, expectedDocument);
          expect(
            resultRequest?.variables['nextToken'],
            response.data?.nextToken,
          );
          expect(resultRequest?.variables['limit'], limit);
          expect(resultRequest?.authorizationMode, req.authorizationMode);
          expect(resultRequest?.apiName, req.apiName);
        },
      );

      test(
        'GraphQLResponse<PaginatedResult<Blog>> will not have data for next page when result has no nextToken',
        () async {
          const limit = 2;
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(Blog.classType, limit: limit);

          const data = '''{
          "listBlogs": {
              "items": [
                {
                  "id": "test-id-1",
                  "name": "Test Blog 1",
                  "createdAt": "2021-07-29T23:09:58.441Z"
                },
                {
                  "id": "test-id-2",
                  "name": "Test Blog 2",
                  "createdAt": "2021-08-03T16:39:18.651Z"
                }
              ]
            }
        }''';

          final GraphQLResponse<PaginatedResult<Blog>> response =
              _decodeResponseData(req, data);
          expect(response.data?.hasNextResult, false);
        },
      );

      test(
        'ModelQueries.list() should correctly populate a request with a simple QueryPredicate',
        () async {
          const expectedTitle = 'Test Blog 1';
          const expectedDocument =
              'query listBlogs(\$filter: ModelBlogFilterInput, \$limit: Int, \$nextToken: String) { listBlogs(filter: \$filter, limit: \$limit, nextToken: \$nextToken) { items { $blogSelectionSet } nextToken } }';
          const expectedFilter = {
            'name': {'eq': expectedTitle},
          };

          final queryPredicate = Blog.NAME.eq(expectedTitle);
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(Blog.classType, where: queryPredicate);

          expect(req.document, expectedDocument);
          expect(req.modelType, isA<PaginatedModelType<Blog>>());
          expect(req.decodePath, 'listBlogs');
          expect(req.variables['filter'], expectedFilter);
        },
      );

      test(
        'getRequestForNextResult() should have same filter as original request',
        () async {
          const limit = 2;
          const expectedTitle = 'Test Blog 1';
          const expectedFilter = {
            'name': {'eq': expectedTitle},
          };

          final queryPredicate = Blog.NAME.eq(expectedTitle);
          final GraphQLRequest<PaginatedResult<Blog>> req =
              ModelQueries.list<Blog>(
                Blog.classType,
                limit: limit,
                where: queryPredicate,
              );
          const data = '''{
          "listBlogs": {
              "items": [
                {
                  "id": "test-id-1",
                  "name": "Test Blog 1",
                  "createdAt": "2021-07-29T23:09:58.441Z"
                },
                {
                  "id": "test-id-2",
                  "name": "Test Blog 2",
                  "createdAt": "2021-08-03T16:39:18.651Z"
                }
              ],
              "nextToken": "super-secret-next-token"
            }
        }''';
          final GraphQLResponse<PaginatedResult<Blog>> response =
              _decodeResponseData(req, data);
          final Map<String, dynamic> firstRequestFilter =
              req.variables['filter'] as Map<String, dynamic>;
          final resultRequest = response.data?.requestForNextResult;

          expect(resultRequest?.variables['filter'], firstRequestFilter);
          expect(resultRequest?.variables['filter'], expectedFilter);
        },
      );

      test(
        'ModelQueries.list() should support additional request parameters',
        () {
          final req = ModelQueries.list(
            Blog.classType,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test(
        'ModelQueries.get() should support model with complex identifier and custom primary key',
        () {
          final customId = uuid();
          final name = 'foo $customId';
          final model = CpkOneToOneBidirectionalParentCD(
            name: name,
            customId: customId,
          );
          final req = ModelQueries.get(
            CpkOneToOneBidirectionalParentCD.classType,
            model.modelIdentifier,
          );
          final expectedDocument =
              'query getCpkOneToOneBidirectionalParentCD { getCpkOneToOneBidirectionalParentCD(customId: "$customId", name: "$name") { customId name createdAt updatedAt cpkOneToOneBidirectionalParentCDImplicitChildId cpkOneToOneBidirectionalParentCDImplicitChildName cpkOneToOneBidirectionalParentCDExplicitChildId cpkOneToOneBidirectionalParentCDExplicitChildName } }';

          expect(req.document, expectedDocument);
          expect(
            deepEquals(req.variables, {'customId': customId, 'name': name}),
            isTrue,
          );
        },
      );

      test(
        'ModelQueries.get() should support model with CPK and int indexes',
        () {
          final customId = uuid();
          final name = 'foo $customId';
          final model = CpkIntIndexes(name: name, fieldA: 1, fieldB: 2);
          final req = ModelQueries.get(
            CpkIntIndexes.classType,
            model.modelIdentifier,
          );
          final expectedDocument =
              'query getCpkIntIndexes { getCpkIntIndexes(name: "$name", fieldA: 1, fieldB: 2) { name fieldA fieldB createdAt updatedAt owner } }';

          expect(req.document, expectedDocument);
        },
      );

      test('ModelQueries.get() should support model with int primary key', () {
        final model = CpkIntPrimaryKey(intAsId: 1, fieldA: 2, fieldB: 3);
        final req = ModelQueries.get(
          CpkIntPrimaryKey.classType,
          model.modelIdentifier,
        );
        const expectedDocument =
            'query getCpkIntPrimaryKey { getCpkIntPrimaryKey(intAsId: 1, fieldA: 2, fieldB: 3) { intAsId fieldA fieldB createdAt updatedAt owner } }';

        expect(req.document, expectedDocument);
      });
    });

    group('ModelMutations', () {
      test('ModelMutations.create() should build a valid request', () {
        final id = uuid();
        const name = 'Test Blog';

        final Blog blog = Blog(id: id, name: name);
        final expectedVars = {
          'input': {'id': id, 'name': name},
        };
        const expectedDoc =
            'mutation createBlog(\$input: CreateBlogInput!, \$condition:  ModelBlogConditionInput) { createBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

        final GraphQLRequest<Blog> req = ModelMutations.create<Blog>(blog);

        expect(req.document, expectedDoc);
        expect(deepEquals(req.variables, expectedVars), isTrue);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'createBlog');
      });

      test(
        'ModelMutations.create() should not include null values for owner fields',
        () {
          const name = 'Test with owner field';
          final customOwnerField = CustomOwnerField(name: name);
          final GraphQLRequest<CustomOwnerField> req =
              ModelMutations.create<CustomOwnerField>(customOwnerField);
          final inputVariable = req.variables['input'] as Map<String, dynamic>;

          expect(inputVariable.containsKey('owners'), isFalse);
        },
      );

      test(
        'ModelMutations.create() should build a valid request for a model with a parent',
        () {
          final blogId = uuid();
          const name = 'Test Blog';
          final Blog blog = Blog(id: blogId, name: name);

          final postId = uuid();
          const title = 'Lorem Ipsum';
          const rating = 1;
          final Post post = Post(
            id: postId,
            title: title,
            rating: rating,
            blog: blog,
          );

          final expectedVars = {
            'input': <String, dynamic>{
              'id': postId,
              'title': title,
              'rating': rating,
              'created': null,
              'blogID': blogId,
            },
          };
          const expectedDoc =
              'mutation createPost(\$input: CreatePostInput!, \$condition:  ModelPostConditionInput) { createPost(input: \$input, condition: \$condition) { id title rating created createdAt updatedAt blog { $blogSelectionSet } blogID } }';
          final GraphQLRequest<Post> req = ModelMutations.create<Post>(post);

          expect(req.document, expectedDoc);
          expect(deepEquals(req.variables, expectedVars), isTrue);
          expect(req.modelType, Post.classType);
          expect(req.decodePath, 'createPost');
        },
      );

      test(
        'ModelMutations.create() should not include parent ID in variables if not in model',
        () {
          final postId = uuid();
          const title = 'Lorem Ipsum';
          const rating = 1;
          final Post post = Post(id: postId, title: title, rating: rating);
          final GraphQLRequest<Post> req = ModelMutations.create<Post>(post);
          expect(
            (req.variables['input'] as Map<String, dynamic>).containsKey(
              'blogID',
            ),
            isFalse,
          );
        },
      );

      test(
        'ModelQueries.create() should support additional request parameters',
        () {
          const name = 'Test Blog';

          final blog = Blog(name: name);
          final req = ModelMutations.create(
            blog,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test('ModelMutations.delete() should build a valid request', () {
        final id = uuid();
        const name = 'Test Blog';

        final Blog blog = Blog(id: id, name: name);

        final expectedVars = {
          'input': {'id': id},
          'condition': null,
        };
        const expectedDoc =
            'mutation deleteBlog(\$input: DeleteBlogInput!, \$condition:  ModelBlogConditionInput) { deleteBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

        final GraphQLRequest<Blog> req = ModelMutations.delete<Blog>(blog);

        expect(req.document, expectedDoc);
        expect(deepEquals(req.variables, expectedVars), isTrue);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'deleteBlog');
      });

      test(
        'ModelQueries.delete() should support additional request parameters',
        () {
          const name = 'Test Blog';

          final blog = Blog(name: name);
          final req = ModelMutations.delete(
            blog,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test('ModelMutations.deleteById() should build a valid request', () {
        final id = uuid();
        final blog = Blog(id: id, name: 'Lorem ipsum $id');

        final expectedVars = {
          'input': {'id': id},
          'condition': null,
        };
        const expectedDoc =
            'mutation deleteBlog(\$input: DeleteBlogInput!, \$condition:  ModelBlogConditionInput) { deleteBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

        final GraphQLRequest<Blog> req = ModelMutations.deleteById<Blog>(
          Blog.classType,
          blog.modelIdentifier,
        );

        expect(req.document, expectedDoc);
        expect(deepEquals(req.variables, expectedVars), isTrue);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'deleteBlog');
      });

      test(
        'ModelQueries.deleteById() should support additional request parameters',
        () {
          final id = uuid();
          final blog = Blog(id: id, name: 'Lorem ipsum $id');
          final req = ModelMutations.deleteById(
            Blog.classType,
            blog.modelIdentifier,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test('ModelMutations.update() should build a valid request', () {
        final id = uuid();
        const name = 'Test Blog';

        final Blog blog = Blog(id: id, name: name);

        final expectedVars = {
          'input': {'id': id, 'name': name},
          'condition': null,
        };
        const expectedDoc =
            'mutation updateBlog(\$input: UpdateBlogInput!, \$condition:  ModelBlogConditionInput) { updateBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

        final GraphQLRequest<Blog> req = ModelMutations.update<Blog>(blog);

        expect(req.document, expectedDoc);
        expect(deepEquals(req.variables, expectedVars), isTrue);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'updateBlog');
      });

      test(
        'ModelMutations.update() should build a valid request for a model with a parent',
        () {
          final blogId = uuid();
          const name = 'Test Blog';
          final Blog blog = Blog(id: blogId, name: name);

          final postId = uuid();
          const title = 'Lorem Ipsum';
          const rating = 1;
          final Post post = Post(
            id: postId,
            title: title,
            rating: rating,
            blog: blog,
          );

          final expectedVars = {
            'input': <String, dynamic>{
              'id': postId,
              'title': title,
              'rating': rating,
              'created': null,
              'blogID': blogId,
            },
            'condition': null,
          };
          const expectedDoc =
              'mutation updatePost(\$input: UpdatePostInput!, \$condition:  ModelPostConditionInput) { updatePost(input: \$input, condition: \$condition) { id title rating created createdAt updatedAt blog { $blogSelectionSet } blogID } }';
          final GraphQLRequest<Post> req = ModelMutations.update<Post>(post);

          expect(req.document, expectedDoc);
          expect(deepEquals(req.variables, expectedVars), isTrue);
          expect(req.modelType, Post.classType);
          expect(req.decodePath, 'updatePost');
        },
      );

      test(
        'ModelMutations.update() should build a valid request with query predicate condition',
        () {
          final id = uuid();
          const name = 'Test Blog';
          final Blog blog = Blog(id: id, name: name);
          final expectedVars = {
            'input': {'id': id, 'name': name},
            'condition': {
              'name': {'lt': 'zzz'},
            },
          };
          const expectedDoc =
              'mutation updateBlog(\$input: UpdateBlogInput!, \$condition:  ModelBlogConditionInput) { updateBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

          final GraphQLRequest<Blog> req = ModelMutations.update(
            blog,
            where: Blog.NAME.lt('zzz'),
          );

          expect(req.document, expectedDoc);
          expect(deepEquals(req.variables, expectedVars), isTrue);
        },
      );

      test(
        'ModelQueries.update() should support additional request parameters',
        () {
          const name = 'Test Blog';
          final blog = Blog(name: name);
          final req = ModelMutations.update(
            blog,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
          );

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
        },
      );

      test(
        'ModelMutations.delete() should build a valid request with query predicate condition',
        () {
          final id = uuid();
          const name = 'Test Blog';
          final Blog blog = Blog(id: id, name: name);
          final expectedVars = {
            'input': {'id': id},
            'condition': {
              'name': {'lt': 'zzz'},
            },
          };
          const expectedDoc =
              'mutation deleteBlog(\$input: DeleteBlogInput!, \$condition:  ModelBlogConditionInput) { deleteBlog(input: \$input, condition: \$condition) { $blogSelectionSet } }';

          final GraphQLRequest<Blog> req = ModelMutations.delete<Blog>(
            blog,
            where: Blog.NAME.lt('zzz'),
          );

          expect(req.document, expectedDoc);
          expect(deepEquals(req.variables, expectedVars), isTrue);
          expect(req.modelType, Blog.classType);
          expect(req.decodePath, 'deleteBlog');
        },
      );

      test(
        'ModelMutations.create() should create model with complex identifier and not include bi-directional children identifiers',
        () {
          final explicitChild = CpkOneToOneBidirectionalChildExplicitCD(
            name: 'abc',
          );
          final implicitChild = CpkOneToOneBidirectionalChildImplicitCD(
            name: 'abc',
          );
          final customId = uuid();
          final parentName = 'parent $customId';
          final parent = CpkOneToOneBidirectionalParentCD(
            name: parentName,
            customId: customId,
            explicitChild: explicitChild,
            implicitChild: implicitChild,
          );
          final req = ModelMutations.create(parent);

          final expectedVars = {
            'input': <String, dynamic>{
              'customId': customId,
              'name': parentName,
              'cpkOneToOneBidirectionalParentCDImplicitChildId': null,
              'cpkOneToOneBidirectionalParentCDImplicitChildName': null,
              'cpkOneToOneBidirectionalParentCDExplicitChildId': null,
              'cpkOneToOneBidirectionalParentCDExplicitChildName': null,
            },
          };
          expect(deepEquals(req.variables, expectedVars), isTrue);
        },
      );

      test(
        'ModelMutations.create() should create child with parent that has complex identifier',
        () {
          final customParentId = uuid();
          final parent = CpkOneToOneBidirectionalParentCD(
            name: 'foo',
            customId: customParentId,
          );
          final child = CpkOneToOneBidirectionalChildExplicitCD(
            name: 'bar',
            belongsToParent: parent,
          );
          final req = ModelMutations.create(child);

          final expectedVars = {
            'input': <String, dynamic>{
              'id': child.id,
              'name': child.name,
              'belongsToParentID': customParentId,
              'belongsToParentName': parent.name,
            },
          };
          expect(deepEquals(req.variables, expectedVars), isTrue);
        },
      );
    });

    group('ModelSubScriptions', () {
      test('ModelSubscriptions.onCreate() should build a valid request', () {
        const expected =
            'subscription onCreateBlog { onCreateBlog { $blogSelectionSet } }';
        final GraphQLRequest<Blog> req = ModelSubscriptions.onCreate<Blog>(
          Blog.classType,
        );

        expect(req.document, expected);
        expect(req.variables, <String, dynamic>{});
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'onCreateBlog');
      });

      test(
        'ModelSubscriptions.onCreate() should support additional request parameters',
        () {
          const expected =
              'subscription onCreateBlog(\$filter: ModelSubscriptionBlogFilterInput) { onCreateBlog(filter: \$filter) { $blogSelectionSet } }';
          final req = ModelSubscriptions.onCreate(
            Blog.classType,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
            where: Blog.NAME.eq('sample'),
          );
          final expectedFilter = {
            'filter': {
              'name': {'eq': 'sample'},
            },
          };

          expect(req.document, expected);
          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
          expect(req.variables, expectedFilter);
        },
      );

      test('ModelSubscriptions.onUpdate() should build a valid request', () {
        const expected =
            'subscription onUpdateBlog { onUpdateBlog { $blogSelectionSet } }';
        final GraphQLRequest<Blog> req = ModelSubscriptions.onUpdate<Blog>(
          Blog.classType,
        );

        expect(req.document, expected);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'onUpdateBlog');
      });

      test(
        'ModelSubscriptions.onUpdate() should support additional request parameters',
        () {
          final req = ModelSubscriptions.onUpdate(
            Blog.classType,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
            where: Blog.NAME.eq('sample'),
          );
          final expectedFilter = {
            'filter': {
              'name': {'eq': 'sample'},
            },
          };

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
          expect(req.variables, expectedFilter);
        },
      );

      test('ModelSubscriptions.onDelete() should build a valid request', () {
        const expected =
            'subscription onDeleteBlog { onDeleteBlog { $blogSelectionSet } }';
        final GraphQLRequest<Blog> req = ModelSubscriptions.onDelete<Blog>(
          Blog.classType,
        );

        expect(req.document, expected);
        expect(req.modelType, Blog.classType);
        expect(req.decodePath, 'onDeleteBlog');
      });

      test(
        'ModelSubscriptions.onDelete() should support additional request parameters',
        () {
          final req = ModelSubscriptions.onDelete(
            Blog.classType,
            apiName: _exampleApiName,
            headers: _exampleHeaders,
            authorizationMode: APIAuthorizationType.function,
            where: Blog.NAME.eq('sample'),
          );
          final expectedFilter = {
            'filter': {
              'name': {'eq': 'sample'},
            },
          };

          expect(req.apiName, _exampleApiName);
          expect(req.headers, _exampleHeaders);
          expect(req.authorizationMode, APIAuthorizationType.function);
          expect(req.variables, expectedFilter);
        },
      );
    });
  });

  group('without ModelProvider', () {
    setUp(() async {
      await Amplify.reset();
    });

    test('should handle no ModelProvider instance', () async {
      await Amplify.addPlugin(MockAmplifyAPI());
      final blog = Blog(name: 'lorem ipsum example');

      try {
        ModelQueries.get<Blog>(Blog.classType, blog.modelIdentifier);
      } on ApiException catch (e) {
        expect(e.message, 'No modelProvider found');
        expect(
          e.recoverySuggestion,
          'Pass in a modelProvider instance while instantiating APIPlugin',
        );
        return;
      }
      fail('Expected an ApiException');
    });
  });
}
