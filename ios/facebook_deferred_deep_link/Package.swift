// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "facebook_deferred_deep_link",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "facebook-deferred-deep-link", targets: ["facebook_deferred_deep_link"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", "18.0.0"..<"19.0.0"),
    ],
    targets: [
        .target(
            name: "facebook_deferred_deep_link",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
