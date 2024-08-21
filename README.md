
<img src="Assets/SSOTPPinView.png" alt="SSOTPPinView">

# SSOTPPinView

SSOTPPinView is a comprehensive library for iOS projects, designed to streamline the creation and customization of OTP (One Time Password) input views. With support for custom keyboards, extensive OTP view customization, and seamless integration with SwiftUI, SSOTPPinView provides a complete solution for secure and user-friendly OTP entry.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![SwiftPM Compatible][spm-image]][spm-url]
[![Version](https://img.shields.io/cocoapods/v/SSOTPPinView.svg?style=flat)](https://cocoapods.org/pods/SSOTPPinView)
[![Platform][platform-image]][platform-url]
[![PRs Welcome][PR-image]][PR-url]

# Screenshots
| Box | Circle | Underline |
| :--: | :-----: | :--: |
| <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSOTPPinView/blob/master/Assets/Box.gif" /> | <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSOTPPinView/blob/master/Assets/Circle.gif" /> | <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSOTPPinView/blob/master/Assets/Underline.gif" /> |

 
# Features!
- Enhance user experience with a tailored keyboard designed for efficient and secure OTP input, or use the default iOS keyboards.
- Implement OTP input fields that are both functional and aesthetically pleasing.
- Personalize the appearance and behavior of the OTP view to match your app's unique style.
- Easily integrate SSOTPPinView into your SwiftUI projects for modern and responsive user interfaces.
  
# Requirements
  - iOS 16+
  - Xcode 14+

# Installation
 **CocoaPods**
 
 [CocoaPods][CocoaPods.org] is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Navigate to project root folder to integrate pod.

```bash
$ pod init
```

It will generate `Podfile` for your project. To integrate SSOTPPinView into your project specify it in your `Podfile`:

```ruby
platform :ios, '16.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SSOTPPinView'
end
```

Then, run the following command:

```bash
$ pod install
```

It will generate `<Project>.xcworkspace` file. From now on you should open the project using this file.

       
**Swift Package Manager**
 
You can install `SSOTPPinView` using [Swift Package Manager] by:

1. Go to `Xcode` -> `File` -> `Add Package Dependencies...`
2. Add package URL [https://cocoapods.org/pods/SSOTPPinView][SSOTPPinView]

```swift
dependencies: [
    .package(url: "https://github.com/SimformSolutionsPvtLtd/SSOTPPinView.git", from: "1.0.1")
]
```

**Manually**

- Add SSOTPPinView folder from /Source folder to your project.

# Usage

```swift
import SSOTPPinView
```
    
```swift
SSOTPPinView(textFieldType: .underline, numberOfCount: 5, keyboardOptions: .customRandomDigits) { newValue in
                self.otp = newValue
            }
            .isSecureTextEntry(true)
            .secureTextType(.dot)
            .textColor(.red)
            .fontWeight(.bold)
            .lineColor(.red)
            .lineWidth(2)
            // custom keyboard property
            .keyboardBackgroundColor(.white)
            .keyFontColor(.red)
            .keyStrokeColor(.blue)
    
```
## 🤝 How to Contribute

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle:

Check out our [**Contributing Guide**](CONTRIBUTING.md) for ideas on contributing.

## Bugs and Feedback

For bugs, feature requests, and discussion use [GitHub Issues].

## Documentation

__[Documentation]__ - Find the full API reference for more detailed documentation.

## Find this samples useful? :heart:

Support it by joining [stargazers] :star: for this repository.

## Check out our other Libraries

<h3><a href="https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries"><u>🗂 Simform Solutions Libraries→</u></a></h3>

## MIT License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

    
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[carthage-image]:https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat
[carthage-url]: https://github.com/Carthage/Carthage
[spm-image]:https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg
[spm-url]: https://swift.org/package-manager
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/assets/svg/badges/C-ffb83f-7198e9a1b7ad7f73977b0c9a5c7c3fffbfa25f262510e5681fd8f5a3188216b0.svg
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
[platform-image]:https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat
[platform-url]:http://cocoapods.org/pods/LFAlertController
[cocoa-image]:https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg
[cocoa-url]:https://img.shields.io/cocoapods/v/LFAlertController.svg
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:http://makeapullrequest.com
[Swift Package Manager]:https://www.swift.org/package-manager
[Github Issues]:https://github.com/SimformSolutionsPvtLtd/SSOTPPinView/issues
[SSOTPPinView]:https://github.com/SimformSolutionsPvtLtd/SSOTPPinView
[CocoaPods]:https://cocoapods.org/pods/SSOTPPinView
[CocoaPods.org]:https://cocoapods.org/
[stargazers]:https://github.com/SimformSolutionsPvtLtd/SSOTPPinView/stargazers
[Documentation]:https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSOTPPinView
