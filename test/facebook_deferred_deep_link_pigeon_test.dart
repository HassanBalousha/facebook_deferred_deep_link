import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link_pigeon.dart';
import 'package:facebook_deferred_deep_link/src/messages.g.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('fetchDeferredDeepLink forwards the host API result', () async {
    final plugin = PigeonFacebookDeferredDeepLink(
      api: FakeFacebookDeferredDeepLinkPluginApi('myapp://settings'),
    );

    expect(await plugin.fetchDeferredDeepLink(), 'myapp://settings');
  });

  test('fetchDeferredDeepLink forwards a null host API result', () async {
    final plugin = PigeonFacebookDeferredDeepLink(
      api: FakeFacebookDeferredDeepLinkPluginApi(null),
    );

    expect(await plugin.fetchDeferredDeepLink(), isNull);
  });
}

class FakeFacebookDeferredDeepLinkPluginApi
    implements FacebookDeferredDeepLinkPluginApi {
  FakeFacebookDeferredDeepLinkPluginApi(this.link);

  final String? link;

  @override
  Future<String?> fetchDeferredDeepLink() async => link;

  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';
}
