//
//  CommonConfig.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit
import SnapKit
class CommonTableViewCellConfig {
    var leftContentViewWidth: ConstraintRelatableTarget?
    var rightContentScrollViewWidth: ConstraintRelatableTarget?
    var rightItemWidth: ConstraintRelatableTarget?
    var rightItemMargin: ConstraintRelatableTarget?
    
    func defaultCellConfig() -> CommonTableViewCellConfig {
        let config = CommonTableViewCellConfig()
        config.leftContentViewWidth = 80.0
        config.rightItemWidth = 100.0
        config.rightItemMargin = 10.0
        return config
    }
}
