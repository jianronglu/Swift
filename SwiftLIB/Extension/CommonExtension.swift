//
//  CommonExtension.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit

enum ClolorWithType: Int {
    case red
    case green
    case gray
    case black
    case orange
    case purple
}

extension UIColor {
    convenience init(rgb: UInt32) {
        let red = CGFloat(rgb & 0xFF0000 >> 16) / 255
        let green = CGFloat(rgb & 0x00FF00 >> 8) / 255
        let blue = CGFloat(rgb & 0x0000FF) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(rgba: UInt32) {
        let r: CGFloat = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgba & 0x0000FF00) >> 8) / 255.0
        let a: CGFloat = CGFloat(rgba & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    func toImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(self.cgColor)
        ctx?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
}
