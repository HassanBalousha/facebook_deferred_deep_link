import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartPackageName: 'facebook_deferred_deep_link',
    dartOut: 'lib/src/messages.g.dart',
    kotlinOut:
        'android/src/main/kotlin/dev/fbdeferred/facebook_deferred_deep_link/Messages.g.kt',
    kotlinOptions:
        KotlinOptions(package: 'dev.fbdeferred.facebook_deferred_deep_link'),
    swiftOut: [
      'ios/facebook_deferred_deep_link/Sources/facebook_deferred_deep_link/Messages.g.swift',
    ],
  ),
)
@HostApi()
abstract class FacebookDeferredDeepLinkPluginApi {
  @async
  String? fetchDeferredDeepLink();
}
