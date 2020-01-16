// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UICircularProgressRing",
    platforms: [
        .iOS(.v10), .tvOS(.v10), .watchOS(.v2)
    ],
    products: [
        .library(
            name: "UICircularProgressRing",
            targets: ["UICircularProgressRing"]
        )
    ],
    targets: [
        .target(
            name: "UICircularProgressRing",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "UICircularProgressRingTests",
            dependencies: ["UICircularProgressRing"],
            path: "Tests"
        )
    ]
)
