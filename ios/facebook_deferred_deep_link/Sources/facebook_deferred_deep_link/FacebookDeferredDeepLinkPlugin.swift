import FBSDKCoreKit
import Flutter
import UIKit

public class FacebookDeferredDeepLinkPlugin: NSObject, FlutterPlugin, FacebookDeferredDeepLinkPluginApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    ApplicationDelegate.shared.initializeSDK()
    FacebookDeferredDeepLinkPluginApiSetup.setUp(
      binaryMessenger: registrar.messenger(), api: FacebookDeferredDeepLinkPlugin())
  }

  func fetchDeferredDeepLink(debug: Bool) async throws -> String? {
    if debug {
      Settings.shared.enableLoggingBehavior(.networkRequests)
      NSLog("[FacebookDeferredDeepLink] Fetching deferred deep link")
    }
    do {
      let link = try await fetch()
      if debug { NSLog("[FacebookDeferredDeepLink] Deferred deep link: %@", link ?? "none") }
      return link
    } catch {
      if debug { NSLog("[FacebookDeferredDeepLink] Deferred deep link fetch failed: %@", "\(error)") }
      throw error
    }
  }

  private func fetch() async throws -> String? {
    try await withCheckedThrowingContinuation { continuation in
      AppLinkUtility.fetchDeferredAppLink { url, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        continuation.resume(returning: url?.absoluteString)
      }
    }
  }
}
