import 'facebook_deferred_deep_link_platform_interface.dart';

/// Fetches the deferred deep link of a Meta (Facebook) app install ad.
class FacebookDeferredDeepLink {
  /// Creates a client for the Facebook deferred deep link API.
  ///
  /// Set [debug] to `true` (for example `kDebugMode`) to log the result and
  /// the Facebook SDK network requests to the native console.
  const FacebookDeferredDeepLink({this.debug = false});

  /// Whether to log the result and the Facebook SDK network requests.
  ///
  /// When `true`, this enables the Facebook SDK request logging for the rest
  /// of the app session. Keep it off in release builds.
  final bool debug;

  /// Asks the Facebook SDK for the deep link of the ad that led to this install.
  ///
  /// Returns `null` when the install did not come from a Meta ad with a deep
  /// link. Meta only returns the link on the first launch after install, so
  /// call this once and persist the result.
  ///
  /// Throws a `PlatformException` when the Facebook SDK fails, for example
  /// when the Facebook App ID is not configured.
  Future<Uri?> fetchDeferredDeepLink() async {
    final link = await FacebookDeferredDeepLinkPlatform.instance
        .fetchDeferredDeepLink(debug: debug);
    if (link == null || link.isEmpty) return null;
    return Uri.tryParse(link);
  }
}
