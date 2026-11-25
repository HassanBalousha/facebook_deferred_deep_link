# facebook_deferred_deep_link

Fetch the **deferred deep link** of a Meta (Facebook) app install ad on Android and iOS.

When a user taps a Meta ad, installs your app and opens it for the first time, this plugin asks the official Facebook SDK for the deep link configured on that ad, so you can send the user straight to the right screen.

## Why this plugin

- **One method, nothing else.** It calls `AppLinkData.fetchDeferredAppLinkData` on Android and `AppLinkUtility.fetchDeferredAppLink` on iOS, and returns the result.
- **Does not change Facebook SDK settings.** It never touches auto-logged app events or advertiser tracking, so it is safe next to [`facebook_app_events`](https://pub.dev/packages/facebook_app_events) and your ad measurement.
- **No lost links.** The result is returned from the call itself. There is no stream to subscribe to before the response arrives.
- **Errors are reported.** Facebook SDK failures surface as a `PlatformException` instead of an empty string.

## Setup

The plugin uses the Facebook SDK that your app already configures. Follow the official setup guides for your Facebook App ID and Client Token:

- **Android:** [Facebook SDK for Android – Getting Started](https://developers.facebook.com/docs/android/getting-started). Add `com.facebook.sdk.ApplicationId` and `com.facebook.sdk.ClientToken` to `AndroidManifest.xml`.
- **iOS:** [Facebook SDK for iOS – Getting Started](https://developers.facebook.com/docs/ios/getting-started). Add `FacebookAppID`, `FacebookClientToken` and `FacebookDisplayName` to `Info.plist`.

Requirements: Android `minSdk` 24, iOS 15. The plugin depends on Facebook SDK 18.x on both platforms.

## Usage

```dart
import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link.dart';

const deferredDeepLink = FacebookDeferredDeepLink();

Future<void> handleFirstLaunch() async {
  final link = await deferredDeepLink.fetchDeferredDeepLink();
  if (link == null) return;

  // e.g. myapp://product?id=42
  navigateTo(link);
}
```

Meta returns the deferred link **only on the first launch after install**. Call `fetchDeferredDeepLink()` once, store the result, and route the user when your app is ready (for example after onboarding or sign in).

## Testing

1. Uninstall the app from the device.
2. Open [App Ads Helper](https://developers.facebook.com/tools/app-ads-helper/), select your app and open **Test Deep Link**.
3. Enter your deep link, tick **Send Notification** and **Send Deferred**, then press **Send to Android** or **Send to iOS**.
4. Install and open the app. `fetchDeferredDeepLink()` returns the link.

The device must have the Facebook app installed and logged in with the account that sent the test.

## Limitations

- **iOS 14.5+:** matching is less reliable when the user has not allowed tracking through App Tracking Transparency, and the method may return `null`. Request ATT before calling it if your app uses tracking.
- Meta does not support deferred deep links for some campaign types, such as SKAdNetwork campaigns. See [Meta's deep linking documentation](https://developers.facebook.com/docs/app-ads/deep-linking).
