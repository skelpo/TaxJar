// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "TaxJar",
    products: [
        .library(name: "TaxJar", targets: ["TaxJar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.1.0")
    ],
    targets: [
        .target(name: "TaxJar", dependencies: ["Vapor"]),
        .testTarget(name: "TaxJarTests", dependencies: ["TaxJar"]),
    ]
)