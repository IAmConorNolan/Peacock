# Peacock

A lightweight, efficient color library for iOS that provides access to perceptual color spaces, particularly Oklab and Oklch.

![Swift](https://img.shields.io/badge/Swift-6.1-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2013.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Overview

Peacock is a tiny, focused Swift library that brings modern perceptual color spaces to iOS development. It's designed to be lightweight and easy to integrate, with a focus on providing accurate color manipulation capabilities through the Oklab and Oklch color spaces.

### Why Perceptual Color Spaces?

Traditional RGB color spaces don't accurately represent how humans perceive color differences. Perceptual color spaces like Oklab are designed to better match human visual perception, making them ideal for:

- Creating visually pleasing color palettes
- Generating accessible color schemes
- Smooth color interpolation
- Consistent lightness across different hues

## Features

- 🎨 **Oklab & Oklch Support**: Full implementation of these modern perceptual color spaces
- 🔄 **Seamless Conversion**: Easy conversion between sRGB, Oklab, and Oklch
- 🧩 **UIKit Integration**: Simple extensions for UIColor
- 🪶 **Lightweight**: Minimal footprint with zero dependencies
- 📱 **iOS 13+ Support**: Works with modern iOS applications

## Installation

### Swift Package Manager

Add Peacock to your project by adding it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Peacock.git", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. Go to File > Add Packages...
2. Enter the repository URL: `https://github.com/yourusername/Peacock.git`
3. Click "Add Package"

## Usage

### Creating Colors in Oklab Space

```swift
import Peacock
import UIKit

// Create a color in Oklab space
let oklabColor = Oklab(L: 0.8, a: 0.1, b: 0.2)

// Convert to UIColor
let uiColor = UIColor(oklab: oklabColor)
```

### Converting Between Color Spaces

```swift
// Get Oklab representation from UIColor
let color = UIColor.systemBlue
let oklab = color.oklab

// Convert to Oklch
let oklch = oklab.oklch
// or directly
let oklchFromColor = color.oklch

// Get back sRGB components
let (r, g, b) = oklab.srgb
```

### Working with Oklch

```swift
// Create a color in Oklch space (L, Chroma, hue)
let oklchColor = Oklch(L: 0.8, C: 0.2, h: .pi/4)

// Convert to Oklab
let oklabFromOklch = oklchColor.oklab

// Create UIColor from Oklch
let uiColorFromOklch = UIColor(oklab: oklchColor.oklab)
```

## Why Oklab?

Oklab is a perceptual color space developed by Björn Ottosson that addresses many of the issues with older color spaces:

- **Perceptual uniformity**: Changes in the color space more closely match perceived color differences
- **Better lightness consistency**: Colors with the same L value appear to have the same lightness
- **Improved hue linearity**: Interpolating between colors produces more visually pleasing results

## Requirements

- iOS 13.0+
- Swift 6.1+

## License

Peacock is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

The mathematical implementation of the Oklab color space is based on the work by Björn Ottosson, which is available under both public domain and MIT license.

## Acknowledgements

- Oklab color space was developed by [Björn Ottosson](https://bottosson.github.io/posts/oklab/)
- The original implementation and research paper can be found at [bottosson.github.io/posts/oklab](https://bottosson.github.io/posts/oklab/)
