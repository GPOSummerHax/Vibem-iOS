//
//  UIColor+Extensions.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let spotifyGreen = UIColor("#1DB954")
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        // e.g. for setBackgroundImage in button to a specific color
        return UIGraphicsImageRenderer(size: size).image { renderedContext in
            self.setFill()
            renderedContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
}
