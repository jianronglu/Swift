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
        let red = CGFloat(rgb & 0xFF0000 >> 16) / 0xff
        let green = CGFloat(rgb & 0x00FF00 >> 8) / 0xff
        let blue = CGFloat(rgb & 0x0000FF) / 0xff
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func hexValue(rgba: UInt32) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let red = CGFloat((rgba & 0xFF000000) >> 24) / 0xff
        let green = CGFloat((rgba & 0x00FF0000) >> 16) / 0xff
        let blue = CGFloat((rgba & 0x0000FF00) >> 8) / 0xff
        let alpha = CGFloat(rgba & 0x000000FF) / 0xff
        return (red, green, blue, alpha)
    }
    
    convenience init(rgba: UInt32) {
        let r = CGFloat((rgba & 0xFF000000) >> 24) / 0xff
        let g = CGFloat((rgba & 0x00FF0000) >> 16) / 0xff
        let b = CGFloat((rgba & 0x0000FF00) >> 8) / 0xff
        let a = CGFloat(rgba & 0x000000FF) / 0xff
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    class func hexString(rgb:String) -> UIColor {
        let value = rgb + "FF"
        return hexString(rgba: value)
    }
    
    class func hexString(rgba:String) -> UIColor {
        if rgba.count != 8 { return .black }
        
        let scanner = Scanner(string: rgba)
        scanner.scanLocation = 0
        
        var rgbaValue: UInt64 = 0
        scanner.scanHexInt64(&rgbaValue)
        
        let r: CGFloat = CGFloat((rgbaValue & 0xFF000000) >> 24) / 0xff
        let g: CGFloat = CGFloat((rgbaValue & 0x00FF0000) >> 16) / 0xff
        let b: CGFloat = CGFloat((rgbaValue & 0x0000FF00) >> 8) / 0xff
        let a: CGFloat = CGFloat(rgbaValue & 0x000000FF) / 0xff

        return UIColor.init(red: r, green: g, blue: b, alpha: a)
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
