// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "ThreePercentServer",
    products: [
        .library(name: "ThreePercentServer", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),

        .package(url: "https://github.com/swift-aws/aws-sdk-swift.git", from: "2.0.2"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "FluentSQLite",
            "Vapor",
            "S3",
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)
