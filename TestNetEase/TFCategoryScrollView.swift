//
//  TFCategoryScrollView.swift
//  TestNetEase
//
//  Created by tiantengfei on 2016/12/15.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import SnapKit

protocol TFCategoryScrollViewDelegate: NSObjectProtocol {
    
    func categoryScrollViewDidChanged(selectedArray: [AnyObject])
    
    func categoryScrollViewDidSelectButton(selectedButtonIndex: Int)
}

class TFCategoryScrollView: UIScrollView {
    weak var categoryDelegate: TFCategoryScrollViewDelegate?
    var categories: [String] = ["头条", "独家", "NBA", "社会", "历史", "军事", "航空", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    
    init() {
        super.init(frame: .zero)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    
        setupButtonView()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
//        
//        setupButtonView()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonView() {
        for category in categories {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.red, for: .normal)
            button.backgroundColor = UIColor.orange
            self.addSubview(button)
            
            button.snp.makeConstraints({ [unowned self] (make) in
//                make.width.equalTo(36)
//                make.height.equalTo(30)
//                make.top.equalToSuperview().offset(1)
                make.centerY.equalTo(self)
                
                if self.subviews.count == 1 {
//                    make.left.equalToSuperview().offset(5)
                    make.left.equalTo(self.snp.left).offset(0)
                } else if self.subviews.count == self.categories.count-1 {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(5)
                    make.right.equalTo(self)
                } else {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(5)
                }
            })
            
//            button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        }
    }
    
    func buttonClicked(sender: UIButton) {
        print(sender.titleLabel?.text ?? "狒狒")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            print(subview.frame)
        }
        
//        guard let lastFrame = subviews.last?.frame else { return }
//        contentSize = CGSize(width: lastFrame.maxX, height: 0)
    }
}
