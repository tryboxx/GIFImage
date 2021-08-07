// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GIFImage",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GIFImage",
            targets: ["GIFImage"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GIFImage",
            dependencies: []
        ),
        .testTarget(
            name: "GIFImageTests",
            dependencies: ["GIFImage"]
        )
    ],
    swiftLanguageVersions: [SwiftVersion.v5]
)
