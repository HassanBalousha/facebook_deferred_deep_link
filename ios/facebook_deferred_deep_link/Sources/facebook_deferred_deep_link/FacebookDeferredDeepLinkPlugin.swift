import FBSDKCoreKit
import Flutter
import UIKit

public class FacebookDeferredDeepLinkPlugin: NSObject, FlutterPlugin, FacebookDeferredDeepLinkPluginApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    ApplicationDelegate.shared.initializeSDK()
    FacebookDeferredDeepLinkPluginApiSetup.setUp(
      binaryMessenger: registrar.messenger(), api: FacebookDeferredDeepLinkPlugin())
  }

  func fetchDeferredDeepLink() async throws -> String? {
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
