import 'package:flutter/foundation.dart';

import 'facebook_deferred_deep_link_platform_interface.dart';
import 'src/messages.g.dart';

/// An implementation of [FacebookDeferredDeepLinkPlatform] that uses Pigeon.
class PigeonFacebookDeferredDeepLink extends FacebookDeferredDeepLinkPlatform {
  /// Creates a new plugin implementation instance.
  PigeonFacebookDeferredDeepLink({
    @visibleForTesting FacebookDeferredDeepLinkPluginApi? api,
  }) : _hostApi = api ?? FacebookDeferredDeepLinkPluginApi();

  final FacebookDeferredDeepLinkPluginApi _hostApi;

  @override
  Future<String?> fetchDeferredDeepLink() => _hostApi.fetchDeferredDeepLink();
}
