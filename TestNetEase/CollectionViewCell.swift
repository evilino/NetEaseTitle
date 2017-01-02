//
//  CollectionViewCell.swift
//  TestNetEase
//
//  Created by 田腾飞 on 2016/12/24.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel = UILabel()
        titleLabel.textColor = .red
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
