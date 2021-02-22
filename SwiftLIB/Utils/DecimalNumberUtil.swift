//
//  DecimalUtils.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/5.
//

import Foundation

class DecimalNumberUtil {
    static func transNumber(num: Float?, precise: UInt?) -> String {
        return transNumber(num: num, style: .decimal, precise: precise)
    }
    
    static func transNumber(num: Float?, style: NumberFormatter.Style, precise: UInt?) -> String {
        guard num != 0 else { return "--"}
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.init(identifier: "zh_CN")
        
        formatter.numberStyle = style
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3

        if let formatterStr = formatter.string(from: NSNumber.init(value: num ?? 0)) {
            return formatterStr
        }
        
        return "--"
    }
    
    class func transNumber(num: Int?, style: NumberFormatter.Style) ->String {
        guard num != 0 else { return "--"}
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = style
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        if let formatterStr = formatter.string(from: NSNumber.init(value: num ?? 0)) {
            return formatterStr
        }
        return "--"
    }
}
