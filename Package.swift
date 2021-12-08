// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DoubleGenerator",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/jpsim/SourceKitten.git", from: "0.31.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.1")
    ],
    targets: [
        .target(
            name: "DoubleGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SourceKittenFramework", package: "SourceKitten"),
                .product(name: "Stencil", package: "Stencil")
            ]
        ),
        .testTarget(
            name: "DoubleGeneratorTests",
            dependencies: ["DoubleGenerator"]),
    ]
)
