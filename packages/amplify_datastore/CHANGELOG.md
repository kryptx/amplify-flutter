## 2.6.5

### Chores
- chore(datastore): Bumped kotlin_version to 2.2.0 ([#6224](https://github.com/aws-amplify/amplify-flutter/pull/6224))
- chore(datastore): Bumped com.android.tools:desugar_jdk_libs to 2.1.5 ([#6224](https://github.com/aws-amplify/amplify-flutter/pull/6224))
- chore(datastore): Bumped com.google.code.gson:gson to 2.13.1 ([#6224](https://github.com/aws-amplify/amplify-flutter/pull/6224))
- chore(datastore): Bumped com.android.tools.build:gradle to 8.11.0 ([#6203](https://github.com/aws-amplify/amplify-flutter/pull/6203))
- chore(datastore): Bumped com.amplifyframework:aws-auth-cognito to 2.29.1 ([#6187](https://github.com/aws-amplify/amplify-flutter/pull/6187))
- chore(datastore): Bumped com.amplifyframework:aws-api to 2.29.1 ([#6187](https://github.com/aws-amplify/amplify-flutter/pull/6187))
- chore(datastore): Bumped com.amplifyframework:aws-datastore to 2.29.1 ([#6187](https://github.com/aws-amplify/amplify-flutter/pull/6187))
- chore(datastore): Bumped com.amplifyframework:aws-api-appsync to 2.29.1 ([#6187](https://github.com/aws-amplify/amplify-flutter/pull/6187))
- chore(datastore): Bumped org.jetbrains.kotlinx:kotlinx-coroutines-android: to 1.10.2 ([#6187](https://github.com/aws-amplify/amplify-flutter/pull/6187))

## 2.6.4

### Chores
- chore(all): Bump Dart SDK to 3.8.0 ([#6165](https://github.com/aws-amplify/amplify-flutter/pull/6165))

## 2.6.3

- Minor bug fixes and improvements

## 2.6.2

### Chores
- chore(all): Bump Dart SDK to 3.7.0 ([#6026](https://github.com/aws-amplify/amplify-flutter/pull/6026))
- chore(datastore): Removed Starscream pinned version

## 2.6.1

- Minor bug fixes and improvements

## 2.6.0

### Fixes
- fix(datastore): properly handle multiple configures on Android ([#5740](https://github.com/aws-amplify/amplify-flutter/pull/5740))

## 2.5.0

- Minor bug fixes and improvements

## 2.4.2

- Minor bug fixes and improvements

## 2.4.1

### Fixes
- fix(datastore): FlutterSerializedModel.extractJsonValue returns `.some(nil)` instead of `nil` ([#5370](https://github.com/aws-amplify/amplify-flutter/pull/5370))

## 2.4.0

### Fixes
- fix(datastore): Clear subscriptions on Stop ([#5253](https://github.com/aws-amplify/amplify-flutter/pull/5253))
- fix(datastore): Restart Sync Engine when network on/off ([#5218](https://github.com/aws-amplify/amplify-flutter/pull/5218))

## 2.3.0

- Minor bug fixes and improvements

## 2.2.1

### Fixes
- fix(datastore): prevent auth plugin from throwing during configuration ([#5132](https://github.com/aws-amplify/amplify-flutter/pull/5132))

## 2.2.0

### Features
- feat: Support Amplify Gen 2 outputs ([#5073](https://github.com/aws-amplify/amplify-flutter/pull/5073))

## 2.1.0

### Features
- feat(datastore): Migrate to Amplify Swift V2 ([#4962](https://github.com/aws-amplify/amplify-flutter/pull/4962))

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

- chore(datastore): Amplify Swift version bump to 1.30.7 ([#4454](https://github.com/aws-amplify/amplify-flutter/pull/4454))

## 1.6.0

- Minor bug fixes and improvements

## 1.5.0

- Minor bug fixes and improvements

## 1.4.2

- Minor bug fixes and improvements

## 1.4.1

- Minor bug fixes and improvements

## 1.4.0

### Fixes

- fix(datastore): Use platform thread ([#3607](https://github.com/aws-amplify/amplify-flutter/pull/3607))

## 1.3.4

### Fixes

- fix(datastore): Pin `Starscream`

## 1.3.3

- Minor bug fixes and improvements

## 1.3.2

### Fixes

- fix(datastore): Custom list serde ([#3544](https://github.com/aws-amplify/amplify-flutter/pull/3544))

## 1.3.1

### Fixes

- fix(datastore): hot restart ([#3497](https://github.com/aws-amplify/amplify-flutter/pull/3497))
- fix(datastore): make event history list thread safe ([#3509](https://github.com/aws-amplify/amplify-flutter/pull/3509))

## 1.3.0

### Features

- feat(datastore): Adds DataStoreHubEventType to DataStoreHubEvents ([#3454](https://github.com/aws-amplify/amplify-flutter/pull/3454))

### Chores

- chore(deps): Bump Amplify Android to 2.11.0

## 1.2.0-supports-only-mobile+1

- chore(datastore): Amplify Swift version bump to 1.30.4 (#3327). Fixes #663, addresses #1693 and #2527 on iOS.

## 1.2.0-supports-only-mobile

- Minor bug fixes and improvements

## 1.1.0-supports-only-mobile+1

### Fixes

- fix(datastore): support nested predicates for observe and observeQuery ([#3029](https://github.com/aws-amplify/amplify-flutter/pull/3029))

## 1.1.0-supports-only-mobile

### Features

- Dart 3 support (must update Dart SDK constraint to `^3.0.0`)

### Fixes

- fix(repo): AGP 8.0 compatibility ([#2942](https://github.com/aws-amplify/amplify-flutter/pull/2942))

## 1.0.0-supports-only-mobile.0+1

### Fixes

- fix(repo): Flutter 3.3 support

## 1.0.0-supports-only-mobile.0

Version 1 of the Amplify libraries have been released to support all the platforms Flutter supports.
When interacting with GraphQL APIs, use the API category for all platforms or DataStore for iOS and Android.
This is because we retained DataStore on the original Android & iOS implementation. We’re
looking to bring data synchronization and offline-first experiences to the web and desktop in the
future and would love to get your feedback on [this GitHub issue](https://github.com/aws-amplify/amplify-flutter/issues/234).

As always, you can find us on [GitHub](https://github.com/aws-amplify/amplify-flutter/) and
[Discord](https://discord.gg/jWVbPfC) to answer any questions you may have.

## 1.0.0-next.8+1

- Minor bug fixes and improvements

## 1.0.0-next.8

- Minor bug fixes and improvements

## 1.0.0-next.7

### Fixes

- fix(android): Bump Amplify Android to 2.4.1
- fix(datastore): support use of java8 features in the example App
- fix(ios): Bump Amplify iOS to 1.29.1

### Breaking Changes

- chore(datastore)!: Reorganize + import cleanup ([#2760](https://github.com/aws-amplify/amplify-flutter/pull/2760))

## 1.0.0-next.6

- Minor bug fixes and improvements

## 1.0.0-next.5

- Minor bug fixes and improvements

## 1.0.0-next.4

### Fixes

- fix(datastore): prevent unhandled exception crashing App rebuilding sync expression

## 1.0.0-next.3

### Breaking Changes

- refactor(core)!: Migrate exception types

## 1.0.0-next.2

- Minor bug fixes and improvements

## 1.0.0-next.1+1

### Fixes

- fix(datastore): adapt amplify-ios CPK fix breaking change
- fix(datastore): cpk errors on a custom type ([#2134](https://github.com/aws-amplify/amplify-flutter/pull/2134))
- fix(datastore): enable java8 desugaring for amplify-android datastore plugin
- fix(datastore): missing query field model name cause ambigous column … ([#1941](https://github.com/aws-amplify/amplify-flutter/pull/1941))
- fix(datastore): update dependency importing paths

### Features

- feat(datastore): add targetNames support for codegen
- feat(datastore): custom primary key Flutter native implementation

## 1.0.0-next.1

- Minor bug fixes and improvements

## 1.0.0-next.0+4

- Minor bug fixes and improvements

## 1.0.0-next.0+3

- Minor bug fixes and improvements

## 1.0.0-next.0+2

- Minor bug fixes and improvements

## 1.0.0-next.0+1

- Minor bug fixes and improvements

## 1.0.0-next.0 (2022-08-02)

Initial developer preview release for all platforms.

### Developer Preview

The Amplify Flutter libraries are being rewritten in Dart. This version is part of our developer preview for all platforms and is **not** intended for production usage. Please follow our [Web](https://github.com/aws-amplify/amplify-flutter/issues/234) and [Desktop](https://github.com/aws-amplify/amplify-flutter/issues/133) support tickets to monitor the status of supported categories. We will be releasing Web and Desktop support for all Amplify categories incrementally.

For production use cases please use the latest, non-tagged versions of amplify-flutter packages from `pub.dev`. They offer a stable, production-ready experience for Android and iOS.

## 0.5.0 (2022-05-17)

### Features

- feat(datastore): Custom Conflict Handler (#1254)
- feat(datastore): emit subscriptionDataProcessed and syncReceived events (#1351)
- feat(datastore): Multi-auth (#1478)

### Fixes

- fix: support lists for .contains query predicate in observeQuery (#1233)

### Chores

- chore: make example Android Apps runnable with API 32+ (#1474)
- chore: update android compileSdkVersion to 31
- chore: upgrade gradle plugin to 7.1.2
- chore: enable android codebase linter checks
- chore: replace 0.4.2-1 with 0.4.3 due to melos limitation (#1496)
- chore: Lint fixes (#1471)
- chore: Flutter 3 fixes (#1580)
- chore: bump amplify-android version to 1.35.3 (#1586)
- chore: downgrade amplify-android to 1.33.0 (#1591)

## 0.4.5 (2022-04-13)

-fix: bumps ios version and bumps api AuthProvider timeout (#1526)

## 0.4.4 (2022-04-06)

## 0.4.3 (2022-04-02)

- chore: bump amplify-ios to 1.22.3

## 0.4.2 (2022-03-24)

- chore: enable query predicate integration tests for float values (#1454)
- chore: bump amplify-android to 1.32.1 (#1448)
- chore: bump amplify-ios to 1.22.0 (#1468)

## 0.4.1 (2022-02-28)

- fix: delete default predicate causes deletion failure (#1409)
- fix: observe may receive duplicate events in Android (#1339)

## 0.4.0 (2022-02-17)

- feat(datastore): Add QueryPredicate to Save/Delete (#1336)
- feat(datastore): Add QueryPredicate to Observe (#1332)
- fix(datastore): DataTime value comparison is inaccurate (#1326)
- chore: bump Kotlin version to 1.6.10 (#1346)
- chore(datastore): Export hub event types (#1330)
- fix(datastore): Hub memory usage (#1201)
- feat(datastore): Add QueryPredicate.all (#1310)
- chore(datastore): update integration tests schema (#1308)

### Breaking Changes

- If your app has a dependency on Kotlin, the value of `ext.kotlin_version` set in `android/build.gradle` must be 1.5.31 or greater (1.6.10 recommended)

## 0.3.2 (2022-01-21)

- chore: bump amplify-android to 1.31.2

## 0.3.1 (2022-01-20)

- chore: bump amplify-ios to 1.18.3

## 0.3.0 (2022-01-20)

This version requires version `>=7.6.10` of `@aws-amplify/cli`. You can install the latest version by running the command:

```
npm install -g @aws-amplify/cli
```

and to regenerate models, run the following command:

```
amplify codegen models
```

### Breaking Changes

- `ModelProvider` and `ModelField` interface changes

  **How to Migrate:**

  - Install the required version of `@aws-amplify/cli` described at the beginning of this section
  - Run `amplify codegen models` to regenerate models

- This version introduces a breaking change to Android Apps as an existing bug writes `Double` and `Boolean` values as `TEXT` in local SQLite database. The fix corrects this behavior. Hence, directly applying this fix may raise SQL error while reading from and writing to local database.

  **How to Migrate:**

  Invoke [`Amplify.DataStore.clear()`](https://docs.amplify.aws/lib/datastore/sync/q/platform/flutter/#clear-local-data) on App start after upgrading to the latest version of Amplify Flutter. This API clears and recreates local database table with correct schema.

  NOTE: Data stored in local database and not synced to cloud will be lost, as [local migration is not supported](https://docs.amplify.aws/lib/datastore/schema-updates/q/platform/flutter/#local-migrations).

### Features

- feat(datastore): Add CustomType functionality (#847)
- feat(datastore): Add ModelField ReadOnly support (#599)

### Fixes

- fix(datastore): configure function triggers initial sync unexpectedly (#986)
- fix(datastore): fix error map from ios (#1126)
- break(datastore): cannot saving boolean as integer in SQLite (#895)

## 0.2.10 (2021-11-23)

## 0.2.9 (2021-11-17)

- chore: upgrade amplify-android to 1.28.3-rc

## 0.2.8 (2021-11-12)

### Fixes

- fix(datastore): (Android) Fix DataStore release mode crash (#1064)

## 0.2.7 (2021-11-08)

### Chores

- chore: Bump Amplify iOS to 1.15.5

### Fixes

- fix(datastore): Temporal date/time query predicates
- fix(datastore): Android TemporalTime Save Issue

## 0.2.6 (2021-10-25)

### Fixes

- fix(datastore): Re-emit events on hot restart

### Features

- feat(datastore): Add observeQuery API

## 0.2.5 (2021-10-14)

### Fixes

- fix(datastore): Sync issues with owner-based auth
- fix(datastore): Ensure attaching nested model schema
- fix(datastore): Timeout period not increasing
- fix(datastore): Remove default pagination behavior on iOS

## 0.2.4 (2021-09-10)

### Fixes

- fix: CocoaPods relative import

## 0.2.3 (2021-09-09)

### Features

- feat(auth): OIDC/Lambda Support (#777)
- feat(datastore): Add start and stop APIs (#811)
- feat(auth): add options to resendSignUpCode (#738)

### Fixes

- fix(amplify_datastore): iOS json deserialization (#806)
- fix(amplify_datastore): Better loggin on unhandled DataStoreHubEvent (#647)
- fix(amplify_datastore): return null for list field in nested model (#843)
- fix(amplify_datastore): fix ios schema change bug (#439)

### Chores

- chore: upgrade amplify-android 1.24.1 (#829)

### Tests

- test(amplify_datastore): add local integration tests for datastore (#831)

## 0.2.2 (2021-08-04)

### Features

- feat: Populate belongs-to nested models (#658)

### Fixes

- fix: Query nested model causes column not found sql error (#761)

## 0.2.1 (2021-07-27)

### Features

- feat: Selective Sync (#703)

### Chores

- chore: upgrade amplify-android to 1.20.1 (#710)
- chore: enable formatting in CI w/ code changes (#570)
- chore: make SubscriptionEvent directly available via datastore plugin by adding to publicTypes in interface (#728)
- chore: add integration tests for datastore (#753)

## 0.2.0 (2021-06-30)

### Breaking Changes

- The previously deprecated configureModelProvider function has been removed.

### Features

- feat: Null safety datastore (#649)
- feat: Null safety core (#492)

### Bug Fixes

- fix(amplify_datstore): mprovider compile issue (#681)
- fix(amplify_datastore): HubEvent null check (#670)

### Chores

- chore: Null safety master rebase (#676)

## 0.1.6 (2021-06-23)

### Features

- feat: Add support of DataStore custom configuration (#610)
- feat: add updateUserAttributes (batch) (#601)

### Fixes

- fix: amplify-ios version bump (#648)
- fix: adds userAttributes to confirmSignIn (#607)
- fix: Add clientMetadata to confirmSignUp API options (#619)

### Chores

- chore: upgrade amplify-android to 1.19.0 (#650)
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

- fix(amplify_datastore): avoid tearing down iOS subscription after clear() (#399)
- fix: Move AddPlugin from Register to MethodChannel (#411)
- fix: upgrade melos (#436)
- fix: upgrade plugin_platform_interface (#447)

## 0.1.0 (2021-02-15)

### Chores

- chore: Bump android version to 1.16.13 (#391)

### Bug Fixes

- fix: Save enum lists properly in iOS (#374)

## 0.0.2-dev.2 (2021-02-09)

### Chores

- chore: Update Readme (#358)
- chore: Don't add API plugin by default for DataStore (#350)
- chore: Introduce new Temporal types (Date, DateTime, Time, Timestamp) for Dart codegen models (#307)
- chore: Refactor error handling to use the new DatastoreException types (#329)
- chore: Updated amplify-android version 1.6.10 (#332)
- chore: Remove adding API plugin by default (#350)

### Bug Fixes

- fix: MissingPluginException when android app restarts (#345)
- fix: Fix minor error handling in dart code (#356)
- fix: Export datastore types (#357)
- fix: Save lists properly in iOS for all types (#364)

## 0.0.2-dev.1 (2021-01-25)

### Chores

- chore: Refactor Hub streams (#262)
- chore: Refactor amplify_core into amplify_flutter (#273)
- chore: Add a new amplify_core package for base types and utilities (#275)
- fix: Send null instead of empty string for nullable enum (#301)

## 0.0.1-dev.6 (2021-01-04)

### Bug Fixes

- fix: fix relative path for coverage.gradle to be local to the package (#293)

## 0.0.1-dev.5 (2020-12-31)

### Chores

- chore(amplify_datastore) Update readme of the sample app (#238)
- chore: Updated amplify-android version 1.6.8. (#261)
- chore: add some missing headers on kotlin files (#269)

### Bug Fixes

- fix(amplify_datastore) Update sample app to match the new model codegen (#237)
- fix(amplify_datastore): Handle optional nullable enum types in parser (#254)

## 0.0.1-dev.4 (2020-12-03)

- Initial preview release of DataStore plugin.
