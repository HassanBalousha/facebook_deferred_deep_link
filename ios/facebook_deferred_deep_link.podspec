Pod::Spec.new do |s|
  s.name             = 'facebook_deferred_deep_link'
  s.version          = '0.1.0'
  s.summary          = 'Fetch Meta (Facebook) deferred deep links in Flutter.'
  s.description      = <<-DESC
Fetches the deferred deep link of a Meta (Facebook) app install ad using the official Facebook SDK.
                       DESC
  s.homepage         = 'https://pub.dev/packages/facebook_deferred_deep_link'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'AlHasssan Balousha' => '' }
  s.source           = { :path => '.' }
  s.source_files = 'facebook_deferred_deep_link/Sources/facebook_deferred_deep_link/**/*.swift'
  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 18.0'
  s.platform = :ios, '15.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.resource_bundles = {'facebook_deferred_deep_link_privacy' => ['facebook_deferred_deep_link/Sources/facebook_deferred_deep_link/PrivacyInfo.xcprivacy']}
end
