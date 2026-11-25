import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'facebook_deferred_deep_link_pigeon.dart';

/// The interface that implementations of facebook_deferred_deep_link must
/// implement.
abstract class FacebookDeferredDeepLinkPlatform extends PlatformInterface {
  /// Constructs a FacebookDeferredDeepLinkPlatform.
  FacebookDeferredDeepLinkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FacebookDeferredDeepLinkPlatform _instance =
      PigeonFacebookDeferredDeepLink();

  /// The instance of [FacebookDeferredDeepLinkPlatform] to use.
  ///
  /// Defaults to [PigeonFacebookDeferredDeepLink].
  static FacebookDeferredDeepLinkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FacebookDeferredDeepLinkPlatform]
  /// when they register themselves.
  static set instance(FacebookDeferredDeepLinkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the raw deferred deep link from the Facebook SDK, or `null`.
  ///
  /// When [debug] is `true`, the result and the Facebook SDK network requests
  /// are logged to the native console.
  Future<String?> fetchDeferredDeepLink({bool debug = false}) {
    throw UnimplementedError(
        'fetchDeferredDeepLink() has not been implemented.');
  }
}
