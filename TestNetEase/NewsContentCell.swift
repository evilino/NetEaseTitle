//
//  TFNewsContentView.swift
//  TFTouTiao
//
//  Created by 田腾飞 on 2016/12/28.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit

class NewsContentCell: UICollectionViewCell {
    var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            titleLabel.text = title
        }
    }
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: CGFloat(Float.random()), green: CGFloat(Float.random()), blue: CGFloat(Float.random()), alpha: 1)
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.text = "田腾飞"
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
