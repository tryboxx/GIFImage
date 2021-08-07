# GIFImage
> Display GIFs in your SwiftUI project

[![SwiftUI](https://img.shields.io/badge/SwiftUI-orange.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)
[![Twitter](https://img.shields.io/badge/twitter-@chrislowiec-blue.svg)](http://twitter.com/chrislowiec)

A lightweight repository for putting GIF files into your project, available as a Swift Package.

## Installation

Add this project on your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/tryboxx/GIFImage.git", .branch("main"))
    ]
)
```

## Usage example


```swift
import GIFImage

struct ContentView: View {

    var body: some View {
        GIFImage(gifName: "gif_file_name")
    }
}
```

## Release History

* 1.0.0
    * Initial release with base `GIFImage` implementation

## Meta

Christopher Lowiec – [@chrislowiec](https://twitter.com/chrislowiec)

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/tryboxx/GIFImage](https://github.com/tryboxx/)
