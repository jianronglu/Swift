//
//  CommonTableView.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit

protocol CommonTableViewDelegate: AnyObject {
    func commonTableViewDidSelectIndex(commonTableView: CommonTableView, model: TableItemModel)
}

typealias CommonClickBlock = (CommonTableView, TableItemModel, IndexPath) -> Void

class CommonTableView: UIView, UITableViewDelegate, UITableViewDataSource,CommonTableViewCellDelegate, CommonTableViewHeaderDelegate {
    
    let commonTableViewCellKey = "commonCellKey"
    let config = CommonTableViewCellConfig().defaultCellConfig()
    var commonHeaderView: CommonTableViewHeader?
        
    var tableView: UITableView?
    var delegate: CommonTableViewDelegate?
    
    var didSelectRowBlock: CommonClickBlock?
    
    private var _dataSource: [TableItemModel]?
    var dataSource: [TableItemModel]? {
        set {
            _dataSource = newValue
            tableView?.reloadData()
        }
        get {
            return _dataSource
        }
    }
    
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
        tableView?.separatorColor = UIColor.init(rgb: 0xBBBBBBB)
        self.addSubview(tableView!)
        
        tableView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: commonTableViewCellKey)
        if cell == nil {
            cell = CommonTableViewCell.init(style: .default, reuseIdentifier: commonTableViewCellKey, config: config)
            cell?.selectionStyle = .none
        }
        let c = cell as! CommonTableViewCell
        if indexPath.row < _dataSource?.count ?? 0 {
            c.setSubViewProperty(model: _dataSource?[indexPath.row] ?? TableItemModel())
        }
        c.delegate = self
        return c
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if didSelectRowBlock == nil {
            didSelectRowBlock = { a, b, c in
                print("a = \(a), b = \(b), c = \(c)")
            }
        }
        didSelectRowBlock!(self, _dataSource?[indexPath.row] ?? TableItemModel(), indexPath)

    }
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40)
        commonHeaderView = CommonTableViewHeader.init(frame: frame)
        commonHeaderView?.delegate = self
        return commonHeaderView!
    }
    
    func commonTableViewCellDidScroll(cell: CommonTableViewCell?, scrollView: UIScrollView) {
        let cells = tableView?.visibleCells
        guard cells?.count != 0 else {
            return
        }
        
        let offset = scrollView.contentOffset
        
        commonHeaderView?.setContentOffset(offset: offset)
        
        // FIXME: 同步滑动有卡顿-需要优化
        for cell  in cells! {
            let c = cell as! CommonTableViewCell
            c.updateScrollViewOffset(offset: offset)
        }
    }
    
    func commonHeaderDidScroll(commonHeaderView: CommonTableViewHeader?, scrollView: UIScrollView) {
        commonTableViewCellDidScroll(cell: nil, scrollView: scrollView)
    }
}
