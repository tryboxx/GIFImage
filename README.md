# GIFImage
> Display GIFs in your SwiftUI project

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![codebeat-badge][codebeat-image]][codebeat-url]

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

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
