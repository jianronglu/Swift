//
//  CommonConfig.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit

class CommonTableViewCellConfig {
    var leftContentViewWidth: CGFloat?
    var rightContentScrollViewWidth: CGFloat?
    var rightItemDefaultWith: CGFloat?
    var rightItemMarginWith: CGFloat?
    
    func defaultCellConfig() -> CommonTableViewCellConfig {
        let config = CommonTableViewCellConfig()
        config.leftContentViewWidth = 80.0
        config.rightItemDefaultWith = 100.0
        config.rightItemMarginWith = 10.0
        return config
    }
}
