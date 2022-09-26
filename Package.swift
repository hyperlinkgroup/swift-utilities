// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_12)
    ],
    products: [
        .library(name: "Log", targets: ["Log"]),
        .library(name: "UtilitiesDate", targets: ["UtilitiesDate"]),
        .library(name: "UtilitiesLocation", targets: ["UtilitiesLocation"]),
        .library(name: "UtilitiesMisc", targets: ["UtilitiesMisc"]),
        .library(name: "UtilitiesUserDefaults", targets: ["UtilitiesUserDefaults"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Log",
            dependencies: [],
            path: "Sources/Log"),
        .target(
            name: "UtilitiesDate",
            dependencies: [],
            path: "Sources/UtilitiesDate"),
        .target(
            name: "UtilitiesLocation",
            dependencies: [],
            path: "Sources/UtilitiesLocation"),
        .target(
            name: "UtilitiesMisc",
            dependencies: [],
            path: "Sources/UtilitiesMisc"),
        .target(
            name: "UtilitiesUserDefaults",
            dependencies: [],
            path: "Sources/UtilitiesUserDefaults"),
    ]
)
