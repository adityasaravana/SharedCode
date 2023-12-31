// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedCode",
    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedCode",
            targets: ["SharedCode"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/MarcoEidinger/OSInfo.git", .upToNextMajor(from: "1.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SharedCode",
            dependencies: [
                .product(name: "OSInfo", package: "OSInfo")
            ]),
        .testTarget(
            name: "SharedCodeTests",
            dependencies: ["SharedCode"]),
    ]
)
