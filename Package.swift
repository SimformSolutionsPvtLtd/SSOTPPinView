// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSOTPPinView",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "SSOTPPinView",
            targets: ["SSOTPPinView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SSOTPPinView",
            path: "Source",
            resources: [
                .copy("Resources/PrivacyInfo.xcprivacy")
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
