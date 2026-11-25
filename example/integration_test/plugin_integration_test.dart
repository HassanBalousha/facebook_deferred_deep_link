import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('fetchDeferredDeepLink reaches the host platform', (
    WidgetTester tester,
  ) async {
    const plugin = FacebookDeferredDeepLink();

    try {
      final link = await plugin.fetchDeferredDeepLink();
      expect(link, anyOf(isNull, isA<Uri>()));
    } on PlatformException catch (e) {
      expect(e.code, isNotEmpty);
    }
  });
}
