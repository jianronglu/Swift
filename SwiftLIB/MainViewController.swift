//
//  MainViewController.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/1.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let CellKey = "cell key"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatSubView()
        
        view.backgroundColor = UIColor.white
        
    }
    
    /// init table view
    func creatSubView()  {
        let tableView = UITableView()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    /// table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CellKey)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellKey)
        }
        print("======\(indexPath.row+1)")
        return cell!;
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "HHHHH"
        print("willDisplay willDisplay \(indexPath.row+1)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
}

