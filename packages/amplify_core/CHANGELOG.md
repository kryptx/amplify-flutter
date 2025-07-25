## 2.6.5

### Fixes
- fix(auth): handle fallthrough exceptions in sign out state ([#6226](https://github.com/aws-amplify/amplify-flutter/pull/6226))

## 2.6.4

### Chores
- chore(all): Bump Dart SDK to 3.8.0 ([#6165](https://github.com/aws-amplify/amplify-flutter/pull/6165))
- chore(auth): remove token query parameters ([#6179](https://github.com/aws-amplify/amplify-flutter/pull/6179))

## 2.6.3

- Minor bug fixes and improvements

## 2.6.2

### Chores
- chore(all): Bump Dart SDK to 3.7.0 ([#6026](https://github.com/aws-amplify/amplify-flutter/pull/6026))

## 2.6.1

- Minor bug fixes and improvements

## 2.6.0

### Features
- feat(storage): add multi-bucket feature support  ([#5681](https://github.com/aws-amplify/amplify-flutter/pull/5681))

### Fixes
- fix(aws_common): removed JS streamed requests ([#5797](https://github.com/aws-amplify/amplify-flutter/pull/5797))

## 2.5.0

### Features
- feat(auth, authenticator): Add support for Email OTP MFA ([#5449](https://github.com/aws-amplify/amplify-flutter/pull/5449)) (#5472)

## 2.4.2

### Features
- feat(api): move App Sync subscription headers to protocol ([#5301](https://github.com/aws-amplify/amplify-flutter/pull/5301))

### Fixes
- fix(api): Reconnect WebSocket when resuming app from a paused state ([#5567](https://github.com/aws-amplify/amplify-flutter/pull/5567))

## 2.4.1

### Fixes
- fix(api): web socket error handling ([#5359](https://github.com/aws-amplify/amplify-flutter/pull/5359))

## 2.4.0

### Features
- feat(Auth): Add fetchCurrentDevice API ([#5251](https://github.com/aws-amplify/amplify-flutter/pull/5251))

### Fixes
- fix(datastore): Restart Sync Engine when network on/off ([#5218](https://github.com/aws-amplify/amplify-flutter/pull/5218))

### Chores
- chore: bump json_annotation dependency to v4.9

## 2.3.0

- Minor bug fixes and improvements

## 2.2.0

### Fixes
- fix(api): GraphQLResponse.toString() include data & errors ([#5079](https://github.com/aws-amplify/amplify-flutter/pull/5079))
- fix(core): improve amplify configure api error message ([#5021](https://github.com/aws-amplify/amplify-flutter/pull/5021))
- fix(notifications): allow offline configuration
- fix: wait for in progress multi part uploads to cancel for `pause` and `cancel`

### Features
- feat: Support Amplify Gen 2 outputs ([#5073](https://github.com/aws-amplify/amplify-flutter/pull/5073))

## 2.1.0

### Features
- feat(datastore): Migrate to Amplify Swift V2 ([#4962](https://github.com/aws-amplify/amplify-flutter/pull/4962))

## 2.0.0

We are thrilled to release version 2.0 of the Amplify Flutter libraries to add support for Amplify Gen 2. Learn more about Amplify Gen 2 at [https://docs.amplify.aws](https://docs.amplify.aws).

This release enables flexible storage paths when using Amplify Gen 2 Storage. This release also addresses several bugs that required breaking changes to resolve. See the change log below for the full list of updates.

If you are upgrading an existing project using Amplify Flutter v1 (created with Amplify Gen 1 CLI or a custom pipeline) please see the [upgrade guide](https://docs.amplify.aws/gen1/flutter/start/project-setup/upgrade-guide/).

As always, you can find us on [GitHub](https://github.com/aws-amplify/amplify-flutter/) and [Discord](https://discord.gg/jWVbPfC) to answer any questions.

### Breaking Changes
- chore(auth)!: remove deprecated auth types ([#4764](https://github.com/aws-amplify/amplify-flutter/pull/4764))
- fix(auth)!: regenerate cognito sdks to update signup operation for adding limit exceeded exception ([#4781](https://github.com/aws-amplify/amplify-flutter/pull/4781))
- chore(analytics)!: remove deprecated apis
- chore(api)!: Model .fromJson() Refactor ([#4665](https://github.com/aws-amplify/amplify-flutter/pull/4665))
- chore(api)!: Removed deprecated members … ([#4772](https://github.com/aws-amplify/amplify-flutter/pull/4772))
- chore(api)!: remove Model.getId() usages ([#4774](https://github.com/aws-amplify/amplify-flutter/pull/4774))
- chore(core)!: make asyncConfig internal
- chore(core)!: removed toJson fallback ([#4793](https://github.com/aws-amplify/amplify-flutter/pull/4793))
- feat(core)!: use plugin options for optional plugin parameters ([#4762](https://github.com/aws-amplify/amplify-flutter/pull/4762))
- feat(smithy)!: remove error match on http status code ([#4750](https://github.com/aws-amplify/amplify-flutter/pull/4750))
- feat(storage)!: Update storage APIs to accept `StoragePath` ([#4713](https://github.com/aws-amplify/amplify-flutter/pull/4713))
- feat(storage)!: move `delimiter` to `S3ListPluginOptions` ([#4773](https://github.com/aws-amplify/amplify-flutter/pull/4773))
- chore(storage)!: rename StorageNotFoundException ([#4770](https://github.com/aws-amplify/amplify-flutter/pull/4770))

### Features
- feat(api): Add attributeExists query predicate ([#4134](https://github.com/aws-amplify/amplify-flutter/pull/4134))

### Fixes
- fix(auth): Android Intent URI Query Parameter Parsing ([#4546](https://github.com/aws-amplify/amplify-flutter/pull/4546))
- fix(auth): map Lambda exceptions correctly ([#4804](https://github.com/aws-amplify/amplify-flutter/pull/4804))

## 1.8.0

### Features
- feat: deprecate `Storage.move()` API ([#4638](https://github.com/aws-amplify/amplify-flutter/pull/4638))
- feat: update `built_value` version constraint ([#4634](https://github.com/aws-amplify/amplify-flutter/pull/4634))
- feat: update plus plugins version ([#4619](https://github.com/aws-amplify/amplify-flutter/pull/4619))

### Fixes
- fix(api): Paginated GraphQL preserve request params ([#4605](https://github.com/aws-amplify/amplify-flutter/pull/4605))
- fix(api): Web socket decode connection errors ([#4606](https://github.com/aws-amplify/amplify-flutter/pull/4606))

## 1.7.0

### Features

- feat(api): add copyWith to GraphQLRequest ([#4365](https://github.com/aws-amplify/amplify-flutter/pull/4365))

### Fixes

- fix: `google.crypto.tink` version constraint ([#4434](https://github.com/aws-amplify/amplify-flutter/pull/4434))

### Chores

- chore(datastore): Amplify Swift version bump to 1.30.7 ([#4454](https://github.com/aws-amplify/amplify-flutter/pull/4454))

## 1.6.3

### Fixes

- fix(auth): forget local device only if matches ([#4060](https://github.com/aws-amplify/amplify-flutter/pull/4060))
- fix: Bumped built_value to ">=8.6.0 <8.9.0" and built_value_generator to 8.8.1
- fix: Bumped drift to ">=2.14.0 <2.15.0" and drift_dev to ">=2.14.0 <2.15.0".
- fix: Bumped path to ">=1.8.0 <2.0.0"

## 1.6.2

### Fixes

- fix(api): GraphQL Model Helpers support lowercase model names #4143 (#4144)
- fix(core): pub docs ([#4049](https://github.com/aws-amplify/amplify-flutter/pull/4049))
- fix(datastore): emit observeQuery snapshot when model create mutation results in an updated model ([#4084](https://github.com/aws-amplify/amplify-flutter/pull/4084))

## 1.6.1

### Fixes

- fix(core): pub docs ([#4049](https://github.com/aws-amplify/amplify-flutter/pull/4049))

## 1.6.0

### Features

- feat: rename sendUserAttributeVerificationCode ([#3759](https://github.com/aws-amplify/amplify-flutter/pull/3759))

### Fixes

- fix(analytics): allow nullable userProfile
- fix(auth): use loadCredentials to check login state
- fix(pub): ignore templates folder during analysis ([#4009](https://github.com/aws-amplify/amplify-flutter/pull/4009))

## 1.5.1

### Fixes

- fix(analytics): event client flush events to do not discard events from cache on auth exception ([#3999](https://github.com/aws-amplify/amplify-flutter/pull/3999))
- fix: catch and log updateEndpoint error during configure ([#3985](https://github.com/aws-amplify/amplify-flutter/pull/3985))

## 1.4.1

### Fixes
- fix(auth): Crash with EXC_BAD_ACCESS ([#3657](https://github.com/aws-amplify/amplify-flutter/pull/3657))
- fix(auth): Custom auth with device tracking, no SRP ([#3652](https://github.com/aws-amplify/amplify-flutter/pull/3652))
- fix(auth): Uncaught Hosted UI cancellation ([#3686](https://github.com/aws-amplify/amplify-flutter/pull/3686))
- fix: removed trailing slash at the end of uri ([#3626](https://github.com/aws-amplify/amplify-flutter/pull/3626))

## 1.4.0

### Features
- feat(auth): TOTP MFA

### Fixes
- fix(analytics): AWSPinpointUserProfile Added null check for user attributes ([#3598](https://github.com/aws-amplify/amplify-flutter/pull/3598))
- fix(auth): SDK exception mapping

## 1.3.3

### Fixes
- fix(auth): Pass `deviceKey` in custom auth challenge
- fix(push): Deserialization from platform maps ([#3557](https://github.com/aws-amplify/amplify-flutter/pull/3557))

## 1.3.2

### Fixes
- fix(core): Cross-zone completion

## 1.3.1

### Fixes
- fix(auth): Remove `nonce` usage ([#3321](https://github.com/aws-amplify/amplify-flutter/pull/3321))
- fix(push): Incorrect handling of simple alert ([#3502](https://github.com/aws-amplify/amplify-flutter/pull/3502))
- perf(auth): Fetch auth session ([#3510](https://github.com/aws-amplify/amplify-flutter/pull/3510))

## 1.3.0

### Features
- feat(auth): Enable ASF
- feat(datastore): Adds DataStoreHubEventType to DataStoreHubEvents ([#3454](https://github.com/aws-amplify/amplify-flutter/pull/3454))

### Fixes
- fix(codegen): Mark Cognito map as sparse ([#3386](https://github.com/aws-amplify/amplify-flutter/pull/3386))
- fix(smithy): Union variant naming ([#3415](https://github.com/aws-amplify/amplify-flutter/pull/3415))

## 1.2.1

### Fixes
- fix(analytics): Disallowed unauth access
- fix(storage): list options pageSize and nextToken params got lost ([#3291](https://github.com/aws-amplify/amplify-flutter/pull/3291))

## 1.2.0

### Fixes
- fix(api): GraphQL subscription with custom domain formats URI correctly ([#3148](https://github.com/aws-amplify/amplify-flutter/pull/3148))
- fix(auth): Attribute key equality ([#3136](https://github.com/aws-amplify/amplify-flutter/pull/3136))
- fix(auth): `signOut` after user deletion ([#3162](https://github.com/aws-amplify/amplify-flutter/pull/3162))
- fix(storage): API doc errors

### Features
- feat(storage): using path style URLs when bucket name contains dots

## 1.1.1

### Fixes
- fix(auth): User attribute serialization
- fix(datastore): support nested predicates for observe and observeQuery ([#3029](https://github.com/aws-amplify/amplify-flutter/pull/3029))

## 1.1.0

### Features
- Dart 3 support (must update Dart SDK constraint to `^3.0.0`)
- feat(core): add granular model read operations ([#2611](https://github.com/aws-amplify/amplify-flutter/pull/2611))

### Fixes
- fix(auth): Fetch AWS credentials after Hosted UI login ([#2956](https://github.com/aws-amplify/amplify-flutter/pull/2956))
- fix(auth): Transform network exceptions ([#2967](https://github.com/aws-amplify/amplify-flutter/pull/2967))
- fix: wait for addPlugin prior to configuration ([#3018](https://github.com/aws-amplify/amplify-flutter/pull/3018))

## 1.0.1

### Fixes
- fix(repo): Flutter 3.3 support
- fix(storage): API doc errors
- fix: convert AuthUserAttributeKey in updateUserAttributes

## 1.0.0

We are thrilled to release version 1.0 of the Amplify Flutter libraries!

This release introduces a full rewrite of the Amplify libraries in Dart, allowing you to build AWS cloud-connected
applications on every platform Flutter supports (iOS, Android, Web, macOS, Windows, and Linux).

If you've been using v0 in production, you can now safely migrate to v1. Check out our 
[migration guide](https://docs.amplify.aws/lib/project-setup/upgrade-guide/q/platform/flutter/) for 
more information.

As always, you can find us on [GitHub](https://github.com/aws-amplify/amplify-flutter/) and 
[Discord](https://discord.gg/jWVbPfC) to answer any questions.

## 1.0.0-next.8+1

### Features
- feat(notifications): implement push notification Flutter iOS module ([#2707](https://github.com/aws-amplify/amplify-flutter/pull/2707))
- feat(notifications): killed state notification handling and Analytics integration ([#2747](https://github.com/aws-amplify/amplify-flutter/pull/2747))
- feat(push): interfaces, category function and types added for push

### Fixes
- fix(auth): Cancel sign in ([#2840](https://github.com/aws-amplify/amplify-flutter/pull/2840))
- fix(core): formatting issues in notifications data types
- fix(notifications): Analytics naming updates, Android test fixes and token received bug fix ([#2824](https://github.com/aws-amplify/amplify-flutter/pull/2824))

## 1.0.0-next.8

### Breaking Changes
- chore(analytics)!: Remove Analytics Prefix ([#2753](https://github.com/aws-amplify/amplify-flutter/pull/2753))
- chore(analytics)!: export endpointManager, redo exports
- chore(auth)!: send Pinpoint Endpoint id to Cognito
- feat(storage)!: update upload APIs options to add metadata field ([#2815](https://github.com/aws-amplify/amplify-flutter/pull/2815))
- fix(storage)!: make S3Exception internal
- refactor(auth)!: Remove generic types ([#2804](https://github.com/aws-amplify/amplify-flutter/pull/2804))
- refactor(core)!: Dependency management
- refactor(storage)!: rename checkObjectExistence to validateObjectExistence
- refactor(storage)!: simplify storage s3 exceptions throwing
- refactor(storage)!: storage category APIs to use category level plugin options ([#2754](https://github.com/aws-amplify/amplify-flutter/pull/2754))

### Fixes
- fix(api): Auth provider registration
- fix(api): Include owner field in selection set ([#2795](https://github.com/aws-amplify/amplify-flutter/pull/2795))
- fix(api): Support model definition target name ([#2814](https://github.com/aws-amplify/amplify-flutter/pull/2814))
- fix(api): Supported protocols should be set on base client only
- fix(auth): Always allow repeated `confirmSignIn` attempts
- fix(auth): Client secret support
- fix(auth): Process sign-in events once
- fix(auth): User pool-only support
- fix(smithy): Add missing `@optionalAuth` traits
- fix(storage): Use `reifyPluginOptions` as instance method
- fix(storage): add handling of AWSHttpException
- fix(storage): remove unnecessary exception for resuming a canceled task

### Features
- feat(storage): add generic StorageOperationCanceledException in core
- feat(storage): add handling of non-ascii object metadata values
- feat(storage): make access level optional for storage APIs ([#2793](https://github.com/aws-amplify/amplify-flutter/pull/2793))
- feat(storage): promote StorageTransferState to amplify_core

## 1.0.0-next.7

### Breaking Changes
- refactor(auth)!: Plugin options ([#2691](https://github.com/aws-amplify/amplify-flutter/pull/2691))

### Fixes
- fix(analytics): event retry logic & max fail tries ([#2713](https://github.com/aws-amplify/amplify-flutter/pull/2713))
- fix(auth): Always pass client metadata
- fix(core): Refine `toJson` outputs when `createFactory = false`

## 1.0.0-next.6

### Breaking Changes
- chore(auth)!: Chain stack traces in state machine
- chore(core)!: Chain stack traces for state machines
- feat(api)!: custom primary key support for GraphQL model helpers ([#2606](https://github.com/aws-amplify/amplify-flutter/pull/2606))

### Fixes
- fix(api): early call of Amplify creates wrong instance of AmplifyClass
- fix(api): write null values in ModelMutations.create() unless owner field ([#2679](https://github.com/aws-amplify/amplify-flutter/pull/2679))
- fix(auth): Transform session expired exceptions ([#2688](https://github.com/aws-amplify/amplify-flutter/pull/2688))
- fix(storage): GetUrl signing

### Features
- feat(api): GraphQL Subscription Where Filter ([#2650](https://github.com/aws-amplify/amplify-flutter/pull/2650))
- feat(storage): optimize part size for multipart upload
- feat(storage): web implementation of transfer database using local storage ([#2631](https://github.com/aws-amplify/amplify-flutter/pull/2631))

## 1.0.0-next.5+1

### Fixes
- fix(api): include parent IDs in selection set for model helpers ([#2655](https://github.com/aws-amplify/amplify-flutter/pull/2655))

## 1.0.0-next.5

### Breaking Changes
- chore(auth)!: Change `AuthCodeDeliveryDetails.attributeKey` to be of type `AuthUserAttributeKey`
- refactor(auth)!: Make attribute update step an enum
- refactor(auth)!: Make reset password step an enum
- refactor(auth)!: Make sign-in step an enum
- refactor(auth)!: Make sign-up step an enum
- refactor(auth)!: Remove category->plugin indirection for `getPlugin`
- refactor(auth)!: State machine facade ([#2482](https://github.com/aws-amplify/amplify-flutter/pull/2482))

### Features
- feat(analytics): Use indexedDB on Web ([#2600](https://github.com/aws-amplify/amplify-flutter/pull/2600))
- feat(storage): enable pause and cancel APIs for download operations

### Fixes
- fix(api): Web Socket Multiple Requests Synchronously ([#2567](https://github.com/aws-amplify/amplify-flutter/pull/2567))
- fix(auth): Device tracking with alias
- fix(auth): Retry sign-in on `ResourceNotFoundException` for device tracking
- fix(auth): `federateToIdentityPool` discrepancies

## 1.0.0-next.4

### Breaking Changes
- fix(auth)!: Fetch Auth Session offline behavior ([#2585](https://github.com/aws-amplify/amplify-flutter/pull/2585))

### Features
- feat(analytics): Legacy data migration of Pinpoint Endpoint ID ([#2489](https://github.com/aws-amplify/amplify-flutter/pull/2489))
- feat(storage): allow configuring transfer acceleration

### Fixes
- fix(api): model helpers use targetNames in schemas with CPK enabled ([#2559](https://github.com/aws-amplify/amplify-flutter/pull/2559))
- fix(auth): Clear credentials before redirect on Web ([#2603](https://github.com/aws-amplify/amplify-flutter/pull/2603))
- fix(auth): Refresh token in non-state machine calls ([#2572](https://github.com/aws-amplify/amplify-flutter/pull/2572))
- fix(auth): SessionExpired Auth Hub event ([#2609](https://github.com/aws-amplify/amplify-flutter/pull/2609))
- fix(storage): incorrect transferred bytes emitted from upload task

## 1.0.0-next.3

### Breaking Changes
- chore(auth)!: Remove `isPreferPrivateSession` from `CognitoSignOutWithWebUIOptions` ([#2538](https://github.com/aws-amplify/amplify-flutter/pull/2538))
- refactor(auth)!: Align exception types
- refactor(auth)!: Make SRP failures errors
- refactor(auth)!: Remove intermediate request types ([#2475](https://github.com/aws-amplify/amplify-flutter/pull/2475))
- refactor(core)!: Migrate exception types

## 1.0.0-next.2+1

### Fixes
- fix(api): Race condition at bloc close
- fix(auth): Add `no-store` cache control header

## 1.0.0-next.2

### Breaking Changes
- chore(auth)!: Make sign in result's `nextStep` non-null ([#2462](https://github.com/aws-amplify/amplify-flutter/pull/2462))
- feat(api)!: Web Socket State Machine  ([#2458](https://github.com/aws-amplify/amplify-flutter/pull/2458))
- feat(auth)!: Support partial sign out cases ([#2436](https://github.com/aws-amplify/amplify-flutter/pull/2436))

### Fixes
- fix(api): support multiple belongsTo ([#2087](https://github.com/aws-amplify/amplify-flutter/pull/2087))
- fix(auth): Can't resubmit verification code ([#2468](https://github.com/aws-amplify/amplify-flutter/pull/2468))

### Features
- feat(auth): Add user ID to `CognitoSignUpResult` ([#2437](https://github.com/aws-amplify/amplify-flutter/pull/2437))

## 1.0.0-next.1+1

### Fixes
- fix(api): Missing query parameters in REST operations ([#2413](https://github.com/aws-amplify/amplify-flutter/pull/2413))
- fix(api): allow setting extra GQL request params from model helpers ([#2423](https://github.com/aws-amplify/amplify-flutter/pull/2423))

## 1.0.0-next.1

### Breaking Changes

Three new categories have added support for Web + Desktop: API, Storage, and Analytics!

See our [docs](https://docs.amplify.aws/lib/q/platform/flutter/) for guides on how to migrate to these new versions.

- chore(api,core): change API types ([#2148](https://github.com/aws-amplify/amplify-flutter/pull/2148))
- chore(storage): migrate interface and setup basic packages 

### Features
- feat(api): GraphQL Custom Request Headers ([#1938](https://github.com/aws-amplify/amplify-flutter/pull/1938))
- feat(api): Subscription Reconnection ([#2074](https://github.com/aws-amplify/amplify-flutter/pull/2074))
- feat(api): authorizationMode property for GraphQLRequest ([#2143](https://github.com/aws-amplify/amplify-flutter/pull/2143))
- feat(core): add AWSFile cross platform file abstraction
- feat(storage): add custom prefix resolver support
- feat(storage): cancel SmithyOperation on upload file pause and cancel
- feat(storage): expose operation control APIs for upload data operation
- feat(storage): revise list API interface and add excludeSubPaths parameter

### Fixes
- fix(api): correct subscription error handling ([#2179](https://github.com/aws-amplify/amplify-flutter/pull/2179))
- fix(api): fix model helper util on web ([#2270](https://github.com/aws-amplify/amplify-flutter/pull/2270))

## 1.0.0-next.0+3

### Features
- feat(core): AWS config file

## 1.0.0-next.0+2

### Features
- feat(auth): Federated sign-in
- feat(core): custom primary key supporting interface changes ([#2141](https://github.com/aws-amplify/amplify-flutter/pull/2141))

## 1.0.0-next.0+1

### Features
- feat(core): Multiple plugin registration

### Fixes
- fix(datastore): correct plugin configuration ([#2122](https://github.com/aws-amplify/amplify-flutter/pull/2122))

## 1.0.0-next.0 (2022-08-02)

Initial developer preview release for all platforms.

### Developer Preview

The Amplify Flutter libraries are being rewritten in Dart. This version is part of our developer preview for all platforms and is **not** intended for production usage. Please follow our [Web](https://github.com/aws-amplify/amplify-flutter/issues/234) and [Desktop](https://github.com/aws-amplify/amplify-flutter/issues/133) support tickets to monitor the status of supported categories. We will be releasing Web and Desktop support for all Amplify categories incrementally.

For production use cases please use the latest, non-tagged versions of amplify-flutter packages from `pub.dev`. They offer a stable, production-ready experience for Android and iOS.

## 0.5.0 (2022-05-17)

### Fixes

- fix(core): Update QueryPagination page field to default to 0 (#1533)

### Chores

- chore: make example Android Apps runnable with API 32+ (#1474)
- chore: update android compileSdkVersion to 31
- chore: upgrade gradle plugin to 7.1.2
- chore: enable android codebase linter checks
- chore: replace 0.4.2-1 with 0.4.3 due to melos limitation (#1496)
- chore: Lint fixes (#1471)
- chore: enable dependabot (#1568)
- chore: Flutter 3 fixes (#1580)
- chore: bump amplify-android version to 1.35.3 (#1586)
- chore: downgrade amplify-android to 1.33.0 (#1591)

## 0.4.5 (2022-04-13)

-fix: bumps ios version and bumps api AuthProvider timeout (#1526)

## 0.4.4 (2022-04-06)

## 0.4.3 (2022-04-02)

- chore: bump amplify-ios to 1.22.3

## 0.4.2 (2022-03-24)

## 0.4.1 (2022-02-28)

- fix: Implement Result in AtomicResult (#1393)
- fix: android atomic result (#1376)

## 0.4.0 (2022-02-17)

- chore: Many model-related type definitions moved from amplify_datastore_plugin_interface to amplify_core.
- chore: bump Kotlin version to 1.6.10 (#1346)

### Breaking Changes

- If your app has a dependency on Kotlin, the value of `ext.kotlin_version` set in `android/build.gradle` must be 1.5.31 or greater (1.6.10 recommended)

## 0.3.2 (2022-01-21)

- chore: bump amplify-android to 1.31.2

## 0.3.1 (2022-01-20)

- chore: bump amplify-ios to 1.18.3

## 0.3.0 (2022-01-20)

### Features

- [Amplify Authenticator](https://pub.dev/packages/amplify_authenticator) preview release!
- New `AmplifyConfig` type for fully-typed configurations

### Fixes

- fix(amplify_auth_cognito): remove int.parse from AuthUserAttribute (#1169)
- fix(amplify_datastore): fix error map from ios (#1126)
- fix(api): OIDC Fixes for REST/GraphQL

## 0.2.10 (2021-11-23)

### Fixes

- fix(auth): Fix coroutines crash (#1132)
- fix(auth): Remove duplicate AtomicResult (#1133)

## 0.2.9 (2021-11-17)

- chore: upgrade amplify-android to 1.28.3-rc

## 0.2.8 (2021-11-12)

### Fixes

- fix(api): "Reply already submitted" crashes (#1058)
- fix(auth): (Android) Dropped exceptions in hosted UI cause `signInWithWebUI` to not return (#1015)
- fix(datastore): (Android) Fix DataStore release mode crash (#1064)
- fix(storage): DateTime formatting and parsing (#1044, #1062)
- fix(storage): Storage.list crash on null "options" (#1061)

## 0.2.7 (2021-11-08)

### Chores

- chore: Bump Amplify iOS to 1.15.5

### Fixes

- fix(api): Fix OIDC/Lambda in REST/GraphQL on Android
- fix(datastore): Temporal date/time query predicates
- fix(datastore): Android TemporalTime Save Issue

## 0.2.6 (2021-10-25)

### Fixes

- fix(datastore): Re-emit events on hot restart

### Features

- feat(datastore): Add observeQuery API
- feat(storage): Upload/download progress listener

## 0.2.5 (2021-10-14)

### Fixes

- fix(datastore): Sync issues with owner-based auth
- fix(datastore): Ensure attaching nested model schema
- fix(datastore): Timeout period not increasing
- fix(datastore): Remove default pagination behavior on iOS
- fix(api): OIDC/Lambda changes for DataStore
- fix(auth): Add global sign out
- fix(auth): Support `preferPrivateSession` flag

## 0.2.4 (2021-09-10)

### Fixes

- fix: CocoaPods relative import

## 0.2.3 (2021-09-09)

### Features

- feat(auth): add options to resendSignUpCode (#738)

### Chores

- chore: upgrade amplify-android 1.24.1 (#829)
- chore(analytics): Apply lints (#810)
- chore(api): Apply lints (#812)

## 0.2.2 (2021-08-04)

### Features

- feat(auth): enables clientMetadata for signUp (#713)
- feat(auth): Auth Devices API (#735)
- feat(datastore): Populate belongs-to nested models (#658)

### Fixes

- fix(analytics): Session start not triggered on Android devices (#764)
- fix(api): prevent some fatal REST errors in Android (#661)
- fix(datastore): Query nested model causes column not found sql error (#761)

### Chores

- chore(api): add support for apiName to GraphQL requests (#553)

## 0.2.1 (2021-07-27)

### Chores

- chore: upgrade amplify-android to 1.20.1 (#710)
- chore: enable formatting in CI w/ code changes (#570)

## 0.2.0 (2021-06-30)

### Features

- feat: Null Safety Auth (#536)
- feat: Null safety core (#492)

### Chores

- chore: Null safety master rebase (#676)

## 0.1.6 (2021-06-23)

### Features

- feat: Add support of DataStore custom configuration (#610)

### Chores

- chore: add httpStatusCode property to ApiException when available from REST response (#590)

## 0.1.5 (2021-05-17)

## 0.1.4 (2021-04-27)

## 0.1.3 (2021-04-21)

## 0.1.2 (2021-04-16)

### Bug Fixes

- fix: handle hot restart (#491)

## 0.1.1 (2021-03-29)

### Chores

- chore: remove upper constraints for flutter 2.0 (#479)

### Bug Fixes

- fix: Move AddPlugin from Register to MethodChannel (#411)
- fix: upgrade plugin_platform_interface (#447)

### Features

- feat(amplify_core): add ktlint to amplify_core android (#403)

## 0.1.0 (2021-02-15)

### Chores

- chore: Bump android version to 1.16.13 (#391)

## 0.0.2-dev.2 (2021-02-09)

### Chores

- chore: Introduce new AmplifyException type and Error utilities (#314)

### Bug Fixes

- fix: MissingPluginException when android app restarts (#345)

## 0.0.2-dev.1 (2021-01-25)

### Chores

- chore: Refactor Hub streams (#262)
- chore: Refactor amplify_core into amplify_flutter (#273)
- chore: Add a new amplify_core package for base types and utilities (#275)

## 0.0.1-dev.6 (2021-01-04)

### Bug Fixes

- fix: fix relative path for coverage.gradle to be local to the package (#293)

## 0.0.1-dev.5 (2020-12-31)

### Chores

- chore: Updated amplify-android version 1.6.8. (#261)
- chore: add some missing headers on kotlin files (#269)

## 0.0.1-dev.4 (2020-12-03)

### Chore

- Updated amplify-android library version to v1.6.6
- Updated amplify-ios library version to v1.4.4

## 0.0.1-dev.3 (2020-10-08)

### Bug Fixes

- fix(amplify_core): tracks configuration for hot restart
- Update example podspecs
- chore: unify gradle versions across repo

## 0.0.1-dev.2 (2020-08-24)

### Bug Fixes

- Bump Android `core` dependency version to 1.1.3.

## 0.0.1-dev.1 (2020-08-17)

- Initial preview release.
