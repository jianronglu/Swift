//
//  CommonTableView.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit

class CommonTableView: UIView, UITableViewDelegate, UITableViewDataSource,CommonTableViewCellDelegate {
    let commonTableViewCellKey = "commonCellKey"
    let config = CommonTableViewCellConfig().defaultCellConfig()
    
    var tableView: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTableView() {
        if tableView == nil {
            tableView = UITableView()
        }
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView()
        tableView?.rowHeight = 50
        tableView?.estimatedRowHeight = 50
        tableView?.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView?.separatorColor = UIColor.init(rgb: 0x999999)
        //tableView?.register(CommonTableViewCell.self, forCellReuseIdentifier: commonTableViewCellKey)
        self.addSubview(tableView!)
        
        tableView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: commonTableViewCellKey)
        if cell == nil {
            cell = CommonTableViewCell.init(style: .default, reuseIdentifier: commonTableViewCellKey, config: config)
            cell?.selectionStyle = .none
        }
        let c = cell as! CommonTableViewCell
        c.delegate = self
        return c
    }
        
    func commonTableViewCellDidScroll(cell: CommonTableViewCell, scrollView: UIScrollView) {
        let cells = tableView?.visibleCells
        guard cells?.count != 0 else {
            return
        }
        // FIXME: 同步滑动有卡顿-需要优化
        for cell  in cells! {
            let c = cell as! CommonTableViewCell
            c.updateScrollViewOffset(offset: scrollView.contentOffset)
        }
        
    }
    
}
