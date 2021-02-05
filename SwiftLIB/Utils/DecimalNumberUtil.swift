//
//  DecimalUtils.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/5.
//

import Foundation

class DecimalNumberUtil {
    static func transNumber(num: Float, precise: uint?) -> String {
        
        let number = NSNumber(value: num)
        
        guard let type = NumberFormatter.Style(rawValue: NumberFormatter.Style.RawValue(precise ?? 2)) else { return "精度有误" }
        
        let decimal = NumberFormatter.localizedString(from: number, number: type)
        
        return decimal
    }
}
