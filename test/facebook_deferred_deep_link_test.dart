import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link.dart';
import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link_pigeon.dart';
import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakeFacebookDeferredDeepLinkPlatform
    with MockPlatformInterfaceMixin
    implements FacebookDeferredDeepLinkPlatform {
  FakeFacebookDeferredDeepLinkPlatform(this._fetch);

  final Future<String?> Function() _fetch;

  @override
  Future<String?> fetchDeferredDeepLink() => _fetch();
}

void main() {
  const plugin = FacebookDeferredDeepLink();

  void givenNativeLink(Future<String?> Function() fetch) {
    FacebookDeferredDeepLinkPlatform.instance =
        FakeFacebookDeferredDeepLinkPlatform(fetch);
  }

  test('PigeonFacebookDeferredDeepLink is the default instance', () {
    expect(
      FacebookDeferredDeepLinkPlatform.instance,
      isInstanceOf<PigeonFacebookDeferredDeepLink>(),
    );
  });

  test('returns the deferred deep link as a Uri', () async {
    givenNativeLink(() async => 'myapp://product?id=42');

    final link = await plugin.fetchDeferredDeepLink();

    expect(link, Uri.parse('myapp://product?id=42'));
    expect(link!.queryParameters['id'], '42');
  });

  test('returns null when Meta has no deferred deep link', () async {
    givenNativeLink(() async => null);

    expect(await plugin.fetchDeferredDeepLink(), isNull);
  });

  test('returns null for an empty link', () async {
    givenNativeLink(() async => '');

    expect(await plugin.fetchDeferredDeepLink(), isNull);
  });

  test('returns null for a link that is not a valid Uri', () async {
    givenNativeLink(() async => 'http://[::1');

    expect(await plugin.fetchDeferredDeepLink(), isNull);
  });

  test('propagates Facebook SDK failures', () async {
    givenNativeLink(
      () async => throw PlatformException(code: 'FacebookSdkNotInitialized'),
    );

    expect(
      plugin.fetchDeferredDeepLink(),
      throwsA(isA<PlatformException>()),
    );
  });
}
