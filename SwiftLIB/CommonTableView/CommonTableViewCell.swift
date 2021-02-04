//
//  CommonTableViewCell.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit
import SnapKit

protocol CommonTableViewCellDelegate: AnyObject {
    func commonTableViewCellDidScroll(cell: CommonTableViewCell?, scrollView: UIScrollView)
}

class CommonTableViewCell: UITableViewCell, UIScrollViewDelegate{
    
    var leftContentView: UIView?
    var rightContentScrollView: UIScrollView?
    
    // MARK - left subViews
    var nameLabel: UILabel?
    var codeLabel: UILabel?
    var tagTypes: [UILabel]?
    
    // MARK - right subViews
    var rightLabels: [UILabel]?
    
    weak var delegate: CommonTableViewCellDelegate?
    
    private var _config: CommonTableViewCellConfig?
    weak var config: CommonTableViewCellConfig? {
        set {
            _config = newValue
            configCell()
        }
        get {
            return _config
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, config: CommonTableViewCellConfig) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.config = config //不能放在init前面
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        configLeftSubView()
        configRighSubView()
    }
    
    private func configLeftSubView() {
        leftContentView = UIView()
        contentView.addSubview(leftContentView!)
        leftContentView?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(commonTableView_lr_margin)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(commonTable_l_viewWidth)
        }
        
        nameLabel = UILabel()
        nameLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel?.textColor = UIColor.init(rgb: 0x333333)
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.textAlignment = .left
        leftContentView?.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(leftContentView!).multipliedBy(0.66)
        })
        
        let tagArr = ["融"]
        tagTypes = []
        for tag in tagArr {
            let label = UILabel()
            label.text = tag
            label.font = UIFont.systemFont(ofSize: 8)
            label.textColor = UIColor.purple
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.purple.cgColor
            label.layer.cornerRadius = 2
            label.textAlignment = .center
            leftContentView?.addSubview(label)
            tagTypes?.append(label)
        }
        
        var preLabel: UILabel?
        
        for label in tagTypes! {
            label.snp.makeConstraints { (make) in
                let size = label.intrinsicContentSize
                make.size.equalTo(CGSize(width: size.width+3, height: size.height+2))
                make.top.equalTo(nameLabel!.snp.bottom)
                if preLabel != nil {
                    make.left.equalTo(preLabel!.snp.right).offset(2)
                } else {
                    make.left.equalToSuperview()
                }
            }
            preLabel = label
        }
        
        codeLabel = UILabel()
        codeLabel?.textColor = UIColor.init(rgb: 0x999999)
        codeLabel?.font = UIFont.systemFont(ofSize: 12)
        codeLabel?.textAlignment = .left
        leftContentView?.addSubview(codeLabel!)

        codeLabel?.snp.makeConstraints({ (make) in
            if preLabel != nil {
                make.left.equalTo(preLabel!.snp.right).offset(2)
                make.centerY.equalTo(preLabel!.snp.centerY)
            } else {
                make.left.equalToSuperview()
                make.top.equalTo(nameLabel!.snp.bottom)
            }
        })
    }
    
    private func configRighSubView() {
        rightContentScrollView = UIScrollView()
        rightContentScrollView?.bounces = false
        rightContentScrollView?.delegate = self
        rightContentScrollView?.showsHorizontalScrollIndicator = false
        contentView.addSubview(rightContentScrollView!)
        rightContentScrollView?.snp.makeConstraints { (make) in
            make.left.equalTo(leftContentView!.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-commonTableView_lr_margin)
        }
        
        rightLabels = []
        let titles = commonTableViewRightItemTitles.components(separatedBy: ",")
        for title in titles {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(rgb: 0x333333)
            label.text = title
            label.textAlignment = .right
            label.adjustsFontSizeToFitWidth = true
            rightContentScrollView?.addSubview(label)
            rightLabels?.append(label)
        }
        
        var preLabel: UILabel?
        for label in rightLabels! {
            label.snp.makeConstraints { (make) in
                if preLabel == nil {
                    make.left.equalToSuperview()
                } else {
                    make.left.equalTo(preLabel!.snp.right).offset(2)
                }
                make.top.height.equalToSuperview()
                make.width.equalTo(commonTableItemWidth)
            }
            preLabel = label
        }
        rightContentScrollView?.contentSize = CGSize(width: (100+2)*titles.count, height: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard delegate != nil else {
            return
        }
        delegate?.commonTableViewCellDidScroll(cell: self, scrollView: rightContentScrollView!)
    }
    
    // 默认就是 internal
    internal func updateScrollViewOffset(offset: CGPoint) {
        rightContentScrollView?.setContentOffset(offset, animated: false)
    }
    
    internal func setSubViewProperty(model: TableItemModel) {
        let stockHq = model.stockHq
        
        nameLabel?.text = stockHq?.name
        codeLabel?.text = stockHq?.code
    }
}
