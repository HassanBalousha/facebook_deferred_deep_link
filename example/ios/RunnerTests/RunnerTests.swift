import Flutter
import Testing
import UIKit

@testable import facebook_deferred_deep_link

struct RunnerTests {

  @Test func pluginConformsToHostApi() {
    let plugin: FacebookDeferredDeepLinkPluginApi = FacebookDeferredDeepLinkPlugin()
    #expect(plugin is FacebookDeferredDeepLinkPlugin)
  }

}
