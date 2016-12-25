//
//  TFCategoryHeaderView.swift
//  TestNetEase
//
//  Created by tiantengfei on 2016/12/15.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit

protocol TFCategoryHeaderViewDelegate: NSObjectProtocol {
    func categoryHeaderView(headerView: TFCategoryHeaderView, selectedIndex: Int)
}

class TFCategoryHeaderView: UIView {
    fileprivate var categoryScrollView: TFCategoryScrollView!
    weak var delegate: TFCategoryHeaderViewDelegate?
    var categories: [String]? {
        didSet {
            categoryScrollView.categories = categories
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryScrollView = TFCategoryScrollView()
        self.addSubview(categoryScrollView)
        self.backgroundColor = UIColor.white
        categoryScrollView.categoryDelegate = self
        categoryScrollView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustTitle(from fromIndex: Int, to toIndex: Int, scale: Float) {
        categoryScrollView.adjustTitle(from: fromIndex, to: toIndex, scale: scale)
    }
    
    func selectTitle(of index: Int) {
        categoryScrollView.selectButton(withFrom: categoryScrollView.currentIndex, to: index)
    }
}

extension TFCategoryHeaderView: TFCategoryScrollViewDelegate {
    fileprivate func categoryScrollView(scrollView: TFCategoryScrollView, selectedButtonIndex: Int) {
        delegate?.categoryHeaderView(headerView: self, selectedIndex: selectedButtonIndex)
    }
}

//MARK: - TFCategoryScrollView

private protocol TFCategoryScrollViewDelegate: NSObjectProtocol {
    func categoryScrollView(scrollView: TFCategoryScrollView, selectedButtonIndex: Int)
}

private class TFCategoryScrollView: UIScrollView {
    weak var categoryDelegate: TFCategoryScrollViewDelegate?
    var currentIndex: Int = 0
    private var colorDigit: Float = 209.0
    
    var categories: [String]?  {
        didSet {
            if let categories = categories {
                setupButtonView(with: categories)
                selectButton(withFrom: currentIndex, to: 0)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonView(with categories: [String]) {
        for (index, category) in categories.enumerated() {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(.black, for: .normal)
            button.tag = index
            self.addSubview(button)
            
            button.snp.makeConstraints({ [unowned self] (make) in
                make.centerY.equalTo(self)
                
                if self.subviews.count == 1 {
                    make.left.equalTo(self.snp.left).offset(15)
                } else if self.subviews.count == self.categories?.count {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(15)
                    make.right.equalTo(self).offset(-15)
                } else {
                    make.left.equalTo((self.subviews[self.subviews.count - 2].snp.right)).offset(15)
                }
            })
        }
    }
    
    func buttonClicked(sender: UIButton) {
        selectButton(withFrom: currentIndex, to: sender.tag)
        categoryDelegate?.categoryScrollView(scrollView: self, selectedButtonIndex: sender.tag)
    }
    
    func selectButton(withFrom currentIndex: Int, to toIndex: Int) {
        let redColor = UIColor(red: CGFloat(colorDigit / 255.0), green: 0.0, blue: 0.0, alpha: 1)
        
        if currentIndex == 0 && toIndex == 0 {
            let currentButton = subviews[currentIndex] as! UIButton
            currentButton.setTitleColor(redColor, for: .normal)
            currentButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        if currentIndex == toIndex {
            return
        }
        
        let currentButton = subviews[currentIndex] as! UIButton
        let desButton = subviews[toIndex] as! UIButton
        
        currentButton.setTitleColor(.black, for: .normal)
        desButton.setTitleColor(redColor, for: .normal)
        currentButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        desButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        self.currentIndex = toIndex
    }
    
    func adjustTitle(from fromIndex: Int, to toIndex: Int, scale: Float) {
        let currentButton = subviews[fromIndex] as! UIButton
        let desButton = subviews[toIndex] as! UIButton
        
        if toIndex > fromIndex {
            currentButton.setTitleColor(UIColor(red: CGFloat((1-scale) * colorDigit / 255.0), green: 0.0, blue: 0.0, alpha: 1), for: .normal)
            currentButton.transform = CGAffineTransform(scaleX: CGFloat(1.2 - 0.2 * scale), y: CGFloat(1.2 - 0.2 * scale))
            desButton.setTitleColor(UIColor(red: CGFloat(scale * colorDigit / 255.0), green: 0.0, blue: 0.0, alpha: 1), for: .normal)
            desButton.transform = CGAffineTransform(scaleX: CGFloat(1.0 + 0.2 * scale), y: CGFloat(1.0 + 0.2 * scale))
        } else {
            desButton.setTitleColor(UIColor(red: CGFloat((1-scale) * colorDigit / 255.0), green: 0.0, blue: 0.0, alpha: 1), for: .normal)
            currentButton.setTitleColor(UIColor(red: CGFloat(scale * colorDigit / 255.0), green: 0.0, blue: 0.0, alpha: 1), for: .normal)
            desButton.transform = CGAffineTransform(scaleX: CGFloat(1.2 - 0.2 * scale), y: CGFloat(1.2 - 0.2 * scale))
            currentButton.transform = CGAffineTransform(scaleX: CGFloat(1.0 + 0.2 * scale), y: CGFloat(1.0 + 0.2 * scale))
        }
    }
}


