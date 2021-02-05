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

protocol SortItemViewDelegate: AnyObject {
    func sortItemDidClicked(sortItemView: SortItemView)
}

enum SortType: Int {
    case Defult
    case Descending
    case Ascending
}

class SortItemView: UIView {
    private var sortImgeView: UIImageView
    private var label: UILabel
    
    var sortType: SortType
    var delegate: SortItemViewDelegate?

    override init(frame: CGRect) {
        sortImgeView = UIImageView()
        label = UILabel()
        sortType = .Defult
        
        super.init(frame: frame)
        layoutPerporty()
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
    
    private func layoutPerporty() {
        self.addSubview(sortImgeView)
        sortImgeView.snp.makeConstraints { (make) in
            make.width.equalTo(6)
            make.height.equalTo(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(sortImgeView.snp.left)
        }
        imageType(type: .Defult)
    }
    func title(text: String?) {
        label.text = text
    }
    
    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        self.addGestureRecognizer(tap)
    }
    
    func textColor(color: UIColor) {
        label.textColor = color
    }
    
    func font(font: UIFont) {
        label.font = font
    }
    
    func textAlignment(align: NSTextAlignment) {
        label.textAlignment = align
    }
    
    func adjustsFontSizeToFitWidth(adjustsFont : Bool) {
        label.adjustsFontSizeToFitWidth = adjustsFont
    }
    
    @objc func click() {
        guard delegate != nil else { return }
        delegate?.sortItemDidClicked(sortItemView: self)
        
        let type = nextType(type: sortType)
        imageType(type: type)
        sortType = type
    }
    func defultType() {
        imageType(type: .Defult)
    }
}

class CommonTableViewHeader: UIView, UIScrollViewDelegate, SortItemViewDelegate {
    var nameLabel: UILabel?
    
    // right subviews
    var rightContentScrollView: UIScrollView?
    var items: [SortItemView]?
    
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
        backgroundColor = UIColor.init(rgb: 0xEEEEEE)
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
        items = []
        for title in titles {
            let item = SortItemView()
            item.font(font: UIFont.systemFont(ofSize: 13))
            item.textColor(color: UIColor.init(rgb: 0x333333))
            item.title(text: title)
            item.textAlignment(align: .right)
            item.adjustsFontSizeToFitWidth(adjustsFont: true)
            rightContentScrollView?.addSubview(item)
            item.delegate = self
            items?.append(item)
        }

        var preItem: SortItemView?
        for item in items! {
            item.snp.makeConstraints { (make) in
                if preItem == nil {
                    make.left.equalToSuperview()
                } else {
                    make.left.equalTo(preItem!.snp.right).offset(2)
                }
                make.top.height.equalToSuperview()
                make.width.equalTo(commonTableItemWidth)
            }
            preItem = item
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
    
    func sortItemDidClicked(sortItemView: SortItemView) {
        guard items?.count != 0 else { return }
        for item in items! {
            if item != sortItemView {
                item.defultType()
            }
        }
    }
}
