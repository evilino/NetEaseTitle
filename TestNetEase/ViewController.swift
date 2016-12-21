//
//  ViewController.swift
//  TestNetEase
//
//  Created by tiantengfei on 2016/12/15.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var headerView: TFCategoryHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = TFCategoryHeaderView()
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(headerView!)
        headerView?.snp.makeConstraints({ [unowned self] (make) in
            make.left.right.equalTo(self.view)
//            make.left.equalToSuperview().offset(0)
            make.height.equalTo(40)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
//            make.top.equalTo(self.view)
        })
    }

}

