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

  test('fetchDeferredDeepLink passes the debug flag to the host', () async {
    final api = FakeFacebookDeferredDeepLinkPluginApi(null);
    final plugin = PigeonFacebookDeferredDeepLink(api: api);

    await plugin.fetchDeferredDeepLink();
    expect(api.receivedDebug, isFalse);

    await plugin.fetchDeferredDeepLink(debug: true);
    expect(api.receivedDebug, isTrue);
  });
}

class FakeFacebookDeferredDeepLinkPluginApi
    implements FacebookDeferredDeepLinkPluginApi {
  FakeFacebookDeferredDeepLinkPluginApi(this.link);

  final String? link;
  bool? receivedDebug;

  @override
  Future<String?> fetchDeferredDeepLink(bool debug) async {
    receivedDebug = debug;
    return link;
  }

  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';
}
