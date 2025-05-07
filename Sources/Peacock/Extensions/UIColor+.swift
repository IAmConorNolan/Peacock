//
//  UIColor.swift
//  Peacock
//
//  Created by Conor Nolan on 07/05/2025.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(oklab: Oklab, alpha: CGFloat = 1.0) {
        let components = oklab.srgb
        self.init(
            red: CGFloat(min(max(components.r, 0), 1)),
            green: CGFloat(min(max(components.g, 0), 1)),
            blue: CGFloat(min(max(components.b, 0), 1)),
            alpha: alpha)
    }

    var oklab: Oklab {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return Oklab.from(srgb: (Double(r), Double(g), Double(b)))
    }

    var oklch: Oklch {
        return oklab.oklch
    }
}
