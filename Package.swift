// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Peacock",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Peacock",
            targets: ["Peacock"]),
    ],
    targets: [
        .target(
            name: "Peacock"),
        .testTarget(
            name: "PeacockTests",
            dependencies: ["Peacock"]
        ),
    ]
)
