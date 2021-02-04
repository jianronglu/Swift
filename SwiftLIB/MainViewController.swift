//
//  MainViewController.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/1.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    var tableView: CommonTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatSubView()
        
        view.backgroundColor = UIColor.white
        
        let vm = CommonViewModel()
        
        weak var wSelf = self
        vm.fetchData { (stockArr, itemArr) in
            wSelf?.tableView?.dataSource = itemArr
        }
    }
    
    /// init table view
    func creatSubView()  {
        tableView = CommonTableView()
        view.addSubview(tableView!)
        tableView?.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

}

