//
//  UIColor+Extensions.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init?(hexCode: String) {
        let r, g, b, a: CGFloat
        if hexCode.hasPrefix("#") {
            let start = hexCode.index(hexCode.startIndex, offsetBy: 1)
            let hexColor = String(hexCode[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        // e.g. for setBackgroundImage in button to a specific color
        return UIGraphicsImageRenderer(size: size).image { renderedContext in
            self.setFill()
            renderedContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    
}
