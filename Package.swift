// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EKKeychainService",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "EKKeychainService",
            targets: ["EKKeychainService"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift.git", from: "19.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "EKKeychainService",
            dependencies: [
                .product(name: "KeychainSwift", package: "KeychainSwift"),
            ]),
        .testTarget(
            name: "EKKeychainServiceTests",
            dependencies: ["EKKeychainService", "KeychainSwift"]),
    ]
)
