//
//  DecimalUtils.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/5.
//

import Foundation

class DecimalNumberUtil {
    static func transNumber(num: Float?, precise: UInt?) -> String {
        guard num != 0 else { return "--"}
        
        let number = NSNumber(value: num!)
        
        guard let type = NumberFormatter.Style(rawValue: NumberFormatter.Style.RawValue(precise ?? 2)) else { return "unknown error" }
        
        let decimal = NumberFormatter.localizedString(from: number, number: type)
        
        return decimal
    }
}
