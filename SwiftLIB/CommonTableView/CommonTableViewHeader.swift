//
//  CommonTableViewHeader.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import UIKit
import SnapKit

typealias Block = (_ type: SortType) -> Void

protocol CommonTableViewHeaderDelegate: AnyObject {
    func commonHeaderDidScroll(commonHeaderView: CommonTableViewHeader?, scrollView: UIScrollView)
}

enum SortType: Int {
    case Defult
    case Descending
    case Ascending
}

class SortView: UIView {
    private var sortImgeView: UIImageView
    private var label: UILabel
    
    var sortType: SortType
    
//    var didClickBlock = Block.self
    
    override init(frame: CGRect) {
        sortImgeView = UIImageView()
        label = UILabel()
        sortType = .Defult
        super.init(frame: frame)
        layoutUI()
        addTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageType(type: SortType?) {
        switch type {
        case .Ascending:
            sortImgeView.image = R.image.option_ascending()
        case .Descending:
            sortImgeView.image = R.image.option_desceding()
        default:
            sortImgeView.image = R.image.option_default()
        }
    }
    
    private func nextType(type: SortType) -> SortType {
        switch type {
        case .Descending:
            return .Ascending
        case .Ascending:
            return .Defult
        default:
            return .Descending
        }
    }
    
    private func layoutUI() {
        self.addSubview(sortImgeView)
        sortImgeView.snp.makeConstraints { (make) in
            make.width.equalTo(8)
            make.height.equalTo(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.init(rgb: 0x333333)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(sortImgeView.snp.left)
        }
    }
    func title(text: String?) {
        label.text = text
    }
    
    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        self.addGestureRecognizer(tap)
    }
    
    @objc func click() {
        let type = nextType(type: sortType)
        imageType(type: type)
        sortType = type
    }
}

class CommonTableViewHeader: UIView, UIScrollViewDelegate {
    var nameLabel: UILabel?
    
    // right subviews
    var rightContentScrollView: UIScrollView?
    var itemLabels: [UILabel]?
    
    var sortImageView: UIImageView?
    
    weak var delegate: CommonTableViewHeaderDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        configLeftSubView()
        configRightSubView()
    }
    
    private func configLeftSubView() {
        nameLabel = UILabel()
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        nameLabel?.textColor = UIColor.init(rgb: 0x333333)
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.textAlignment = .left
        nameLabel?.text = commonTableViewLeftTilte
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(commonTableView_lr_margin)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(commonTable_l_viewWidth)
        }
    }
    
    func configRightSubView() {
        rightContentScrollView = UIScrollView()
        rightContentScrollView?.bounces = false
        rightContentScrollView?.delegate = self
        rightContentScrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(rightContentScrollView!)
        
        rightContentScrollView?.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel!.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-commonTableView_lr_margin)
        }
        
        let titles = commonTableViewRightItemTitles.components(separatedBy: ",")
        itemLabels = []
        for title in titles {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(rgb: 0x333333)
            label.text = title
            label.textAlignment = .right
            label.adjustsFontSizeToFitWidth = true
            rightContentScrollView?.addSubview(label)
            itemLabels?.append(label)
        }

        var preLabel: UILabel?
        for label in itemLabels! {
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
    
    func setContentOffset(offset: CGPoint) {
        rightContentScrollView?.setContentOffset(offset, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard delegate != nil else { return }
        
        delegate?.commonHeaderDidScroll(commonHeaderView: self, scrollView: scrollView)
    }
}
