//
//  TFCategoryHeaderView.swift
//  TestNetEase
//
//  Created by tiantengfei on 2016/12/15.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import SnapKit


class TFCategoryHeaderView: UIView {
    var categoryScrollView: TFCategoryScrollView?
    
    init() {
        super.init(frame: .zero)
        categoryScrollView = TFCategoryScrollView()
        self.addSubview(categoryScrollView!)
        self.backgroundColor = UIColor.white
        categoryScrollView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
