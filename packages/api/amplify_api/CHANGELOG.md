## 2.6.5

- Minor bug fixes and improvements

## 2.6.4

### Chores
- chore(all): Bump Dart SDK to 3.8.0 ([#6165](https://github.com/aws-amplify/amplify-flutter/pull/6165))

## 2.6.3

- Minor bug fixes and improvements

## 2.6.2

### Chores
- chore(all): Bump Dart SDK to 3.7.0 ([#6026](https://github.com/aws-amplify/amplify-flutter/pull/6026))

## 2.6.1

- Minor bug fixes and improvements

## 2.6.0

- Minor bug fixes and improvements

## 2.5.0

- Minor bug fixes and improvements

## 2.4.2

### Fixes
- fix(api): Reconnect WebSocket when resuming app from a paused state ([#5567](https://github.com/aws-amplify/amplify-flutter/pull/5567))

## 2.4.1

- Minor bug fixes and improvements

## 2.4.0

- Minor bug fixes and improvements

## 2.3.0

- Minor bug fixes and improvements

## 2.2.0

### Features
- feat: Support Amplify Gen 2 outputs ([#5073](https://github.com/aws-amplify/amplify-flutter/pull/5073))

## 2.1.0

- Minor bug fixes and improvements

## 2.0.0

We are thrilled to release version 2.0 of the Amplify Flutter libraries to add support for Amplify Gen 2. Learn more about Amplify Gen 2 at [https://docs.amplify.aws](https://docs.amplify.aws).

If you are upgrading an existing project using Amplify Flutter v1 (created with Amplify Gen 1 CLI or a custom pipeline) please see the [upgrade guide](https://docs.amplify.aws/gen1/flutter/start/project-setup/upgrade-guide/).

As always, you can find us on [GitHub](https://github.com/aws-amplify/amplify-flutter/) and [Discord](https://discord.gg/jWVbPfC) to answer any questions.

### Breaking Changes
- chore!: Model .fromJson() Refactor ([#4665](https://github.com/aws-amplify/amplify-flutter/pull/4665))
- chore!: Removed deprecated members … ([#4772](https://github.com/aws-amplify/amplify-flutter/pull/4772))
- chore!: remove Model.getId() usages ([#4774](https://github.com/aws-amplify/amplify-flutter/pull/4774))
- feat!: use plugin options for optional plugin parameters ([#4762](https://github.com/aws-amplify/amplify-flutter/pull/4762))

### Features
- feat: Add attributeExists query predicate ([#4134](https://github.com/aws-amplify/amplify-flutter/pull/4134))

## 1.8.0

### Features
- feat: update plus plugins version ([#4619](https://github.com/aws-amplify/amplify-flutter/pull/4619))

## 1.7.0

### Features
- feat(api): add copyWith to GraphQLRequest ([#4365](https://github.com/aws-amplify/amplify-flutter/pull/4365))

## 1.6.2

### Fixes
- fix(api): GraphQL Model Helpers support lowercase model names #4143 (#4144)

## 1.6.1

- Minor bug fixes and improvements

## 1.6.0

- Minor bug fixes and improvements

## 1.5.0

- Minor bug fixes and improvements

## 1.4.0

- Minor bug fixes and improvements

## 1.3.2

- Minor bug fixes and improvements

## 1.3.1

- Minor bug fixes and improvements

## 1.3.0

- Minor bug fixes and improvements

## 1.2.0

### Fixes
- fix(api): GraphQL subscription with custom domain formats URI correctly ([#3148](https://github.com/aws-amplify/amplify-flutter/pull/3148))

## 1.1.1

- Minor bug fixes and improvements

## 1.1.0

### Features
- Dart 3 support (must update Dart SDK constraint to `^3.0.0`)

## 1.0.1

### Fixes
- fix(repo): Flutter 3.3 support

## 1.0.0

We are thrilled to release version 1.0 of the Amplify Flutter libraries!

This release introduces a full rewrite of the Amplify libraries in Dart, allowing you to build AWS cloud-connected
applications on every platform Flutter supports (iOS, Android, Web, macOS, Windows, and Linux).

If you've been using v0 in production, you can now safely migrate to v1. Check out our 
[migration guide](https://docs.amplify.aws/lib/project-setup/upgrade-guide/q/platform/flutter/) for 
more information.

As always, you can find us on [GitHub](https://github.com/aws-amplify/amplify-flutter/) and 
[Discord](https://discord.gg/jWVbPfC) to answer any questions.

### New Features in the API category

* `GraphQLRequest` now has an `authorizationMode` property so callers can specify the authorization mode directly.
* `GraphQLRequest` now has a `headers` property to specify HTTP headers.
* GraphQL subscriptions will automatically reconnect when losing internet, or when changing from Wi-fi to cellular data or vice versa.
* GraphQL model helpers now support [custom primary keys](https://docs.amplify.aws/cli/graphql/data-modeling/#configure-a-primary-key).
* GraphQL subscription model helpers (`ModelSubscriptions`) now support a `where` clause to use server-side subscription filters via model helpers.

### Bug Fixes

The following issues have been fixed in this release:

- Custom primary key support ([#1426](https://github.com/aws-amplify/amplify-flutter/issues/1426))
- api Model helpers should not pass null fields ([#2492](https://github.com/aws-amplify/amplify-flutter/issues/2492))
- Authentication Type For Api ([#1557](https://github.com/aws-amplify/amplify-flutter/issues/1557))
- Adding Headers to Outgoing Requests ([#1217](https://github.com/aws-amplify/amplify-flutter/issues/1217))
- Custom HTTP Interceptors ([#798](https://github.com/aws-amplify/amplify-flutter/issues/798))
- Cannot perform DELETE action with body from android device ([#1569](https://github.com/aws-amplify/amplify-flutter/issues/1569))

## 1.0.0-next.8+1

- Minor bug fixes and improvements

## 1.0.0-next.8

### Fixes
- fix(api): Auth provider registration
- fix(api): Include owner field in selection set ([#2795](https://github.com/aws-amplify/amplify-flutter/pull/2795))

## 1.0.0-next.7

- Minor bug fixes and improvements

## 1.0.0-next.6

### Fixes
- fix(api): early call of Amplify creates wrong instance of AmplifyClass
- fix(api): write null values in ModelMutations.create() unless owner field ([#2679](https://github.com/aws-amplify/amplify-flutter/pull/2679))

### Breaking Changes
- feat(api)!: custom primary key support for GraphQL model helpers ([#2606](https://github.com/aws-amplify/amplify-flutter/pull/2606))

### Features
- feat(api): GraphQL Subscription Where Filter ([#2650](https://github.com/aws-amplify/amplify-flutter/pull/2650))

## 1.0.0-next.5+1

### Fixes
- fix(api): include parent IDs in selection set for model helpers ([#2655](https://github.com/aws-amplify/amplify-flutter/pull/2655))

## 1.0.0-next.5

### Fixes
- fix(api): Web Socket Multiple Requests Synchronously ([#2567](https://github.com/aws-amplify/amplify-flutter/pull/2567))

## 1.0.0-next.4

### Fixes
- fix(api): do not include null values in ModelMutations.create ([#2504](https://github.com/aws-amplify/amplify-flutter/pull/2504))
- fix(api): model helpers use targetNames in schemas with CPK enabled ([#2559](https://github.com/aws-amplify/amplify-flutter/pull/2559))

## 1.0.0-next.3

### Breaking Changes
- refactor(auth)!: Align exception types
- refactor(core)!: Migrate exception types

### Fixes
- fix(api): SubscriptionDataPayload error decoding type fix ([#2483](https://github.com/aws-amplify/amplify-flutter/pull/2483))
- fix(api): improve GQL subscription error visibility/recovery ([#2507](https://github.com/aws-amplify/amplify-flutter/pull/2507))
- fix(api): prevent GQL subscription race condition error after shutdown ([#2494](https://github.com/aws-amplify/amplify-flutter/pull/2494))

## 1.0.0-next.2+1

### Fixes
- fix(api): Race condition at bloc close

## 1.0.0-next.2

### Breaking Changes
- feat(api)!: Web Socket State Machine  ([#2458](https://github.com/aws-amplify/amplify-flutter/pull/2458))

### Fixes
- fix(api): support multiple belongsTo ([#2087](https://github.com/aws-amplify/amplify-flutter/pull/2087))

## 1.0.0-next.1+1

### Fixes
- fix(api): allow setting extra GQL request params from model helpers ([#2423](https://github.com/aws-amplify/amplify-flutter/pull/2423))
- fix(api): fix subscription race condition from previous connection close ([#2405](https://github.com/aws-amplify/amplify-flutter/pull/2405))
- fix(api): Missing query parameters in REST operations ([#2413](https://github.com/aws-amplify/amplify-flutter/pull/2413))

## 1.0.0-next.1

### Breaking Changes

Initial preview release of the Dart rewrite!

See our [docs](https://docs.amplify.aws/lib/q/platform/flutter/) for guides on how to migrate to this new version.

- chore(api,core): change API types ([#2148](https://github.com/aws-amplify/amplify-flutter/pull/2148))

### Fixes
- fix(api): correct subscription error handling ([#2179](https://github.com/aws-amplify/amplify-flutter/pull/2179))
- fix(api): fix model helper util on web ([#2270](https://github.com/aws-amplify/amplify-flutter/pull/2270))

### Features
- feat(api): GraphQL Custom Request Headers ([#1938](https://github.com/aws-amplify/amplify-flutter/pull/1938))
- feat(api): Subscription Reconnection ([#2074](https://github.com/aws-amplify/amplify-flutter/pull/2074))
- feat(api): authorizationMode property for GraphQLRequest ([#2143](https://github.com/aws-amplify/amplify-flutter/pull/2143))

## 1.0.0-next.0+5

- Minor bug fixes and improvements

## 1.0.0-next.0+4

- Minor bug fixes and improvements

## 1.0.0-next.0+3

- Minor bug fixes and improvements

## 1.0.0-next.0+2

- Minor bug fixes and improvements

## 1.0.0-next.0+1

- Fix package analysis issue

## 1.0.0-next.0 (2022-08-02)

Initial developer preview release for all platforms.

### Developer Preview

The Amplify Flutter libraries are being rewritten in Dart. This version is part of our developer preview for all platforms and is **not** intended for production usage. Please follow our [Web](https://github.com/aws-amplify/amplify-flutter/issues/234) and [Desktop](https://github.com/aws-amplify/amplify-flutter/issues/133) support tickets to monitor the status of supported categories. We will be releasing Web and Desktop support for all Amplify categories incrementally.

For production use cases please use the latest, non-tagged versions of amplify-flutter packages from `pub.dev`. They offer a stable, production-ready experience for Android and iOS.

## 0.5.0 (2022-05-17)

### Fixes

- fix(auth): Fix FlutterAuthProvider.kt (#1505)

### Chores

- chore(amplify_api): federated plugin (#1410)
- chore: make example Android Apps runnable with API 32+ (#1474)
- chore: update android compileSdkVersion to 31
- chore: upgrade gradle plugin to 7.1.2
- chore: enable android codebase linter checks
- chore: replace 0.4.2-1 with 0.4.3 due to melos limitation (#1496)
- chore: Lint fixes (#1471)
- chore: Flutter 3 fixes (#1580)

## 0.4.5 (2022-04-13)

-fix: bumps ios version and bumps api AuthProvider timeout (#1526)

## 0.4.4 (2022-04-06)

- fix(api): JNI issues (#1509)

## 0.4.3 (2022-04-02)

- chore: bump amplify-ios to 1.22.3

## 0.4.2 (2022-03-24)

- fix: model helpers query predicates correctly translates query by associated id (#1417)
- chore: support decoding custom list request (#1420)
- chore: bump amplify-android to 1.32.1 (#1448)
- chore: bump amplify-ios to 1.22.0 (#1468)

## 0.4.1 (2022-02-28)

- chore: clean up some code to limit analysis infos (#1404)

## 0.4.0 (2022-02-17)

- chore: bump Kotlin version to 1.6.10 (#1346)
- feat(amplify_api): model-based Graphql helpers (#1211)

### Breaking Changes

- The `data` field is now nullable in `GraphQLResponse`.
- If your app has a dependency on Kotlin, the value of `ext.kotlin_version` set in `android/build.gradle` must be 1.5.31 or greater (1.6.10 recommended)

## 0.3.2 (2022-01-21)

- chore: bump amplify-android to 1.31.2

## 0.3.1 (2022-01-20)

- chore: bump amplify-ios to 1.18.3

## 0.3.0 (2022-01-20)

### Breaking Changes

- This version changes GraphQL subscription interface to use Streams. See the README.md file for additional information.

### Features

- feat(api): GraphQL Subscription Stream (#905)

### Fixes

- fix(api): remove tabs from graphql document strings in android (#1178)
- fix(api): OIDC Fixes for REST/GraphQL

## 0.2.10 (2021-11-23)

## 0.2.9 (2021-11-17)

- chore: upgrade amplify-android to 1.28.3-rc

## 0.2.8 (2021-11-12)

### Fixes

- fix(api): "Reply already submitted" crashes (#1058)

## 0.2.7 (2021-11-08)

### Chores

- chore: Bump Amplify iOS to 1.15.5

### Fixes

- fix(api): Fix OIDC/Lambda in REST/GraphQL on Android

## 0.2.6 (2021-10-25)

## 0.2.5 (2021-10-14)

### Fixes

- fix(api): OIDC/Lambda changes for DataStore

## 0.2.4 (2021-09-10)

### Fixes

- fix: CocoaPods relative import

## 0.2.3 (2021-09-09)

### Features

- feat(auth): OIDC/Lambda Support (#777)
- feat(auth): add options to resendSignUpCode (#738)

### Chores

- chore: upgrade amplify-android 1.24.1 (#829)
- chore(amplify_api): skip FlutterURLSessionTests (#795)
- chore(api): Apply lints (#812)

### Fixes

- fix(api): OIDC/Lambda Fixes (#862)

## 0.2.2 (2021-08-04)

### Fixes

- fix: prevent some fatal REST errors in Android (#661)

### Chores

- chore: add support for apiName to GraphQL requests (#553)

## 0.2.1 (2021-07-27)

### Bug Fixes

- fix: Prevent type error when using sound null safety (#693)

### Chores

- chore: upgrade amplify-android to 1.20.1 (#710)
- chore: add GraphQL integration tests (#694)
- chore: Add API response headers/status (#721)

## 0.2.0 (2021-06-30)

### Features

- feat(amplify_api): Null safety api (#484)
- feat: Null safety core (#492)

### Bug Fixes

- fix: Null safety master fixes pr (#614)

### Chores

- chore: Null safety master rebase (#676)

## 0.1.6 (2021-06-23)

### Features

- feat: add updateUserAttributes (batch) (#601)

### Fixes

- fix: amplify-ios version bump (#648)
- fix: adds userAttributes to confirmSignIn (#607)
- fix: Add clientMetadata to confirmSignUp API options (#619)

### Chores

- chore: upgrade amplify-android to 1.19.0 (#650)
- chore: add httpStatusCode property to ApiException when available from REST response (#590)
- chore: pin Amplify iOS to '~> 1.9.2' (#589)

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
- fix: call return in addPlugin (#478)

## 0.1.0 (2021-02-15)

### Chores

- chore: Bump android version to 1.16.13 (#391)

## 0.0.2-dev.2 (2021-02-03)

### Features

- feat: Implement the GraphQL Subscribe API (#338)

### Chores

- chore: Updated amplify-android version 1.6.10 (#332)
- chore: Refactor error handling to use the new ApiException type (#339)

### Bug Fixes

- fix: MissingPluginException when android app restarts (#345)

## 0.0.2-dev.1 (2021-01-25)

### Chores

- chore: Refactor amplify_core into amplify_flutter (#273)
- chore: Add a new amplify_core package for base types and utilities (#275)

## 0.0.1-dev.6 (2021-01-04)

### Bug Fixes

- fix: fix relative path for coverage.gradle to be local to the package (#293)

## 0.0.1-dev.5

- Initial preview release of API plugin.
