//
//  BaseCommonCell.swift
//  SwiftLIB
//
//  Created by 陆建荣 on 2021/2/20.
//

import UIKit
import SnapKit


class BaseCommonCell: UIControl {
    var title: String? {
        didSet {
            self.titleView.text = title
        }
    }
    var image: UIImage? {
        didSet {
            self.iconImageView.image = image
        }
    }
    
    var iconImageView: UIImageView
    var titleView: UILabel
    var bottomLine: UIView
    var arrowView: UIImageView
    var hilightView: UIView
    
    override init(frame: CGRect) {
        iconImageView = UIImageView()
        titleView = UILabel()
        bottomLine = UIView()
        arrowView = UIImageView()
        hilightView = UIView()
        super.init(frame: frame)
        self.setupSubViews()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        self.addSubview(titleView)
        titleView.textColor = UIColor.init(rgb: 0x333333)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(1 / UIScreen.main.scale)
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(6)
            make.height.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(hilightView)
        hilightView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        hilightView.alpha = 0
        hilightView.isHidden = true
        hilightView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = self.isHighlighted
            if isHighlighted  {
                self.hilightView.alpha = 1
                self.hilightView.isHidden = false
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.hilightView.alpha = 0
                } completion: { (finish) in
                    self.hilightView.isHidden = true
                }
            }
        }
    }
}

