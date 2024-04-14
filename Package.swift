//
//  Package.swift
//  YummyDate
//
//  Created by Sam Roman on 4/14/24.
//
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YummyDate",
    platforms: [
       .iOS(.v15)
    ],
    products: [
        .library(
            name: "YummyDate",
            targets: ["YummyDate"]),
    ],
    dependencies: [
    ],
    targets: [
            .target(
                name: "YummyDate",
                dependencies: [],
                path: "Sources/YummyDate"
            ),
            .testTarget(
                name: "YummyDateTests",
                dependencies: ["YummyDate"],
                path: "Tests/YummyDateTests"
            ),
        ]
)
