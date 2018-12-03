// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "TaxJar",
    products: [
        .library(name: "TaxJar", targets: ["TaxJar"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "TaxJar", dependencies: []),
        .testTarget(name: "TaxJarTests", dependencies: ["TaxJar"]),
    ]
)