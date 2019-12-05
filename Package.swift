// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "URLImage",
    platforms: [.iOS(.v13), .tvOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "URLImage",
            targets: ["URLImage"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "URLImage",
            dependencies: []
        )
    ],
    swiftLanguageVersions: [.v5]
)
