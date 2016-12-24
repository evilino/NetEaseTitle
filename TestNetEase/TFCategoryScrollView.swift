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
    var currentIndex: Int = 0
    
    var categories: [String] = ["头条", "独家", "NBA", "社会", "历史", "军事", "航空", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        setupButtonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonView() {
        for (index, category) in categories.enumerated() {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.red, for: .normal)
            button.tag = index
            self.addSubview(button)
            
            button.snp.makeConstraints({ [unowned self] (make) in
                make.centerY.equalTo(self)
                
                if self.subviews.count == 1 {
                    make.left.equalTo(self.snp.left).offset(15)
                } else if self.subviews.count == self.categories.count-1 {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(15)
                    make.right.equalTo(self)
                } else {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(15)
                }
            })
            
        }
    }
    
    func buttonClicked(sender: UIButton) {
        selectButton(withFrom: currentIndex, to: sender.tag)
        print(sender.titleLabel?.text ?? "狒狒")
    }
    
    /// 选中某个标题
    func selectButton(withFrom currentIndex: Int, to toIndex: Int) {
        let currentButton = subviews[currentIndex] as! UIButton
        let desButton = subviews[toIndex] as! UIButton
        
        currentButton.setTitleColor(.red, for: .normal)
        currentButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        desButton.setTitleColor(.green, for: .normal)
        desButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        self.currentIndex = toIndex
    }
}

extension TFCategoryScrollView {
    //根据滑动来调整UI
    func adjustHeader(withScale: CGFloat, oldIndex: Int, newIndex: Int) {
        
    }
    
    //让标题居中
    func adjustCategoryToCenter(ofCurrentIndex: Int) {
        
    }
    
    //设置当前的标题
    func setCategory(of index: Int) {
        
    }
    
    //重新设置内容
    func reloadContent(withCategories: [String]) {
        
    }
}
