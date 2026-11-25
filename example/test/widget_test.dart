import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link_platform_interface.dart';
import 'package:facebook_deferred_deep_link_example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakeFacebookDeferredDeepLinkPlatform
    with MockPlatformInterfaceMixin
    implements FacebookDeferredDeepLinkPlatform {
  @override
  Future<String?> fetchDeferredDeepLink({bool debug = false}) async =>
      'myapp://settings';
}

void main() {
  testWidgets('shows the fetched deferred deep link', (tester) async {
    FacebookDeferredDeepLinkPlatform.instance =
        FakeFacebookDeferredDeepLinkPlatform();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Deep link: myapp://settings'), findsOneWidget);
  });
}
