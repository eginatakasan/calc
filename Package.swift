// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Calculator",
    platforms: [
        .macOS(.v10_13)
    ],
    targets: [
        .executableTarget(
            name: "Calculator",
            path: "calc",
            exclude: ["CalcTest"]
        ),
        .testTarget(
            name: "CalculatorTests",
            dependencies: ["Calculator"],
            path: "CalcTest"
        )
    ]
)