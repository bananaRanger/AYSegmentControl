# AYSegmentControl


[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/AYSegmentControl.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/AYSegmentControl)
[![Version](https://img.shields.io/cocoapods/v/AYSegmentControl.svg?style=flat)](https://cocoapods.org/pods/AYSegmentControl)
[![License](https://img.shields.io/cocoapods/l/AYSegmentControl.svg?style=flat)](https://cocoapods.org/pods/AYSegmentControl)
[![Platform](https://img.shields.io/cocoapods/p/AYSegmentControl.svg?style=flat)](https://cocoapods.org/pods/AYSegmentControl)

<p align="center">
  <img width="300" height="170" src="https://github.com/bananaRanger/AYSegmentControl/blob/master/Resources/logo.png?raw=true">
</p>

A special control that provides one or more buttons in a single view for selecting between different screens, views, or modes in your app.

## Demo

<p align="center">
  <img width="162" height="355" src="https://github.com/bananaRanger/AYSegmentControl/blob/master/Resources/demo.mov?raw=true">
</p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## About

A special control that provides one or more buttons in a single view for selecting between different screens, views, or modes in your app.

## Installation

AYSegmentControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR-TARGET-NAME' do
  use_frameworks!
	pod 'AYSegmentControl'
end
```

## Usage

```swift
// 'segmentControl' - object of class 'AYSegmentControl' (control).
// 'titles' - object of class '[String]' (titles list).

segmentControl.segmentTitles = titles
segmentControl.isSelectionIndicatorHidden = false

segmentControl.selectedTextColor = .darkText
segmentControl.textColor = .lightGray
segmentControl.lineColor = .purple

segmentControl.lineHeight = 2
segmentControl.lineCornerRadius = segmentControl.lineHeight / 2
segmentControl.select(segment: 0, with: false)
```

## Author

Anton Yereshchenko

## License

AYSegmentControl is available under the MIT license. See the LICENSE file for more info.

