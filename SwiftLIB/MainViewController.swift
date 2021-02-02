//
//  MainViewController.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/1.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatSubView()
        
        view.backgroundColor = UIColor.white
        
        let vm = CommonViewModel()

        vm.fetchData { (array) in
            print(array)
        }
        
        vm.fetchLocalJson()
        
    }
    
    /// init table view
    func creatSubView()  {
        let tableView = CommonTableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

}

