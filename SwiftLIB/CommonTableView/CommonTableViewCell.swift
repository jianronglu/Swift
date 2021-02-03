//
//  CommonTableViewCell.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/2.
//

import UIKit
import SnapKit

protocol CommonTableViewCellDelegate: AnyObject {
    func commonTableViewCellDidScroll(cell: CommonTableViewCell, scrollView: UIScrollView)
}


class CommonTableViewCell: UITableViewCell, UIScrollViewDelegate{
    let lr_margin = 10.0
    let l_view_width = 90.0
    
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
        }
        get {
            return _config
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, config: CommonTableViewCellConfig) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.config = config //不能放在init前面
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell() {
        configLeftSubView()
        configRighSubView()
    }
    
    func configLeftSubView() {
        leftContentView = UIView()
        contentView.addSubview(leftContentView!)
        leftContentView?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(lr_margin)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(l_view_width);
        }
        
        nameLabel = UILabel()
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        nameLabel?.text = "四维图新"
        nameLabel?.textColor = UIColor.init(rgb: 0x333333)
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.textAlignment = .left
        leftContentView?.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(leftContentView!.snp_centerYWithinMargins)
        })
        
        let tagArr = ["融"]
        tagTypes = []
        for tag in tagArr {
            let label = UILabel()
            label.text = tag
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = UIColor.red
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.cornerRadius = 2
            label.textAlignment = .center
            leftContentView?.addSubview(label)
            tagTypes?.append(label)
        }
        
        var preLabel: UILabel?
        
        for label in tagTypes! {
            label.snp.makeConstraints { (make) in
                make.top.equalTo(nameLabel!.snp_bottomMargin).offset(10)
                let width = label.intrinsicContentSize.width
                make.width.equalTo(width+3)
                if preLabel != nil {
                    make.left.equalTo(preLabel!.snp_rightMargin).offset(10)
                } else {
                    make.left.equalToSuperview()
                }
            }
            preLabel = label
        }
        
        codeLabel = UILabel()
        codeLabel?.text = "002405"
        codeLabel?.textColor = UIColor.init(rgb: 0x999999)
        codeLabel?.font = UIFont.systemFont(ofSize: 10)
        codeLabel?.textAlignment = .left
        leftContentView?.addSubview(codeLabel!)

        codeLabel?.snp.makeConstraints({ (make) in
            if preLabel != nil {
                make.left.equalTo(preLabel!.snp_rightMargin).offset(10)
            } else {
                make.left.equalToSuperview()
            }
            make.top.equalTo(nameLabel!.snp_bottomMargin).offset(10)
        })
    }
    
    func configRighSubView() {
        
        rightContentScrollView = UIScrollView()
        rightContentScrollView?.bounces = false
        rightContentScrollView?.delegate = self
        rightContentScrollView?.showsHorizontalScrollIndicator = false
        contentView.addSubview(rightContentScrollView!)
        rightContentScrollView?.snp.makeConstraints { (make) in
            make.left.equalTo(leftContentView!.snp_rightMargin).offset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-lr_margin)
        }
        
        rightLabels = []
        let titles = commonTableViewHeaderTitles.components(separatedBy: ",")
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
                    make.left.equalTo(preLabel!.snp_rightMargin).offset(10)
                }
                make.top.height.equalToSuperview()
                make.width.equalTo(100)
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
    
    func updateScrollViewOffset(offset: CGPoint) {
        rightContentScrollView?.setContentOffset(offset, animated: false)
    }
    
    func setSubViewProperty(model: StockHQ) {
        nameLabel?.text = model.name
        codeLabel?.text = model.code
    }
}
