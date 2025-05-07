//
//  File 2.swift
//  Peacock
//
//  Created by Conor Nolan on 07/05/2025.
//

import Foundation

public struct Oklch {
    public var L: Double
    public var C: Double
    public var h: Double // radians

    public init(L: Double, C: Double, h: Double) {
        self.L = L
        self.C = C
        self.h = h
    }

    /// Convert to Oklab representation
    public var oklab: Oklab {
        let a = C * cos(h)
        let b = C * sin(h)
        return Oklab(L: L, a: a, b: b)
    }
}
