//
//  File 2.swift
//  Peacock
//
//  Created by Conor Nolan on 07/05/2025.
//

import Foundation

public struct Oklab {
    public var L: Double
    public var a: Double
    public var b: Double

    public init(L: Double, a: Double, b: Double) {
        self.L = L
        self.a = a
        self.b = b
    }

    /// Create Oklab from sRGB components (0...1)
    public static func from(srgb: (r: Double, g: Double, b: Double)) -> Oklab {
        let rLin = srgbToLinear(srgb.r)
        let gLin = srgbToLinear(srgb.g)
        let bLin = srgbToLinear(srgb.b)

        let lms = dot(Matrix.m1, [rLin, gLin, bLin])

        let lHat = cbrt(lms[0])
        let mHat = cbrt(lms[1])
        let sHat = cbrt(lms[2])

        let okl = dot(Matrix.m2, [lHat, mHat, sHat])
        return Oklab(L: okl[0], a: okl[1], b: okl[2])
    }

    /// sRGB components (r, g, b) in 0...1
    public var srgb: (r: Double, g: Double, b: Double) {
        let lHat = L + Transform.a1 * a + Transform.b1 * b
        let mHat = L + Transform.a2 * a + Transform.b2 * b
        let sHat = L + Transform.a3 * a + Transform.b3 * b

        let lLin = lHat * lHat * lHat
        let mLin = mHat * mHat * mHat
        let sLin = sHat * sHat * sHat

        let rgbLin = Oklab.dot(Matrix.invM1, [lLin, mLin, sLin])

        let r = linearToSrgb(rgbLin[0])
        let g = linearToSrgb(rgbLin[1])
        let b = linearToSrgb(rgbLin[2])

        return (r, g, b)
    }

    /// Convert to Oklch representation
    public var oklch: Oklch {
        let C = sqrt(a * a + b * b)
        let h = atan2(b, a)
        return Oklch(L: L, C: C, h: h)
    }

    // MARK: - Internal Math Helpers

    private enum Matrix {
        static let m1: [[Double]] = [
            [0.8189330101, 0.3618667424, -0.1288597137],
            [0.0329845436, 0.9293118715,  0.0361456387],
            [0.0482003018, 0.2643662691,  0.6338517070]
        ]
        static let m2: [[Double]] = [
            [0.2104542553,  0.7936177850, -0.0040720468],
            [1.9779984951, -2.4285922050,  0.4505937099],
            [0.0259040371,  0.7827717662, -0.8086757660]
        ]
        static let invM1: [[Double]] = [
            [ 1.2270138511, -0.5577999807,  0.2812561484],
            [-0.0405801784,  1.1122568696, -0.0716766787],
            [-0.0763812845, -0.4214819784,  1.5861632204]
        ]
        static let invM2: [[Double]] = [
            [0.9999999985,  0.3963377922,  0.2158037581],
            [1.0000000089, -0.1055613423, -0.0638541748],
            [1.0000000547, -0.0894841821, -1.2914855480]
        ]
    }

    private enum Gamma {
        static let srgbToLinearThreshold = 0.04045
        static let linearToSrgbThreshold = 0.0031308
        static let gamma = 2.4
        static let invGamma = 1.0 / 2.4
    }

    private enum Transform {
        static let a1 = 0.3963377774
        static let b1 = 0.2158037573
        static let a2 = -0.1055613458
        static let b2 = -0.0638541748
        static let a3 = -0.0894841775
        static let b3 = -1.2914855480
    }

    private static func dot(_ m: [[Double]], _ v: [Double]) -> [Double] {
        m.map { row in zip(row, v).map(*).reduce(0, +) }
    }

    private static func srgbToLinear(_ c: Double) -> Double {
        c <= Gamma.srgbToLinearThreshold
            ? c / 12.92
            : pow((c + 0.055) / 1.055, Gamma.gamma)
    }

    private func linearToSrgb(_ c: Double) -> Double {
        c <= Gamma.linearToSrgbThreshold
            ? 12.92 * c
            : 1.055 * pow(c, Gamma.invGamma) - 0.055
    }
}
