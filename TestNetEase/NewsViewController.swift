//
//  NewsViewController.swift
//  TestNetEase
//
//  Created by 田腾飞 on 2016/12/24.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    fileprivate var headerView: HeaderView!
    fileprivate var contentCollectionView: ContentCollectionView!
    
    lazy var categories: [String] = {
        return ["头条", "独家", "NBA", "社会", "历史", "军事", "航空", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        do {
            headerView = HeaderView()
            headerView.delegate = self
            view.addSubview(headerView)
            headerView.categories = categories
            headerView.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(40)
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            })
        }
        
        do {
            contentCollectionView = ContentCollectionView()
            contentCollectionView.dataSource = self
            contentCollectionView.delegate = self
            contentCollectionView.register(cellClass: NewsContentCell.self, forCellWithReuseIdentifier: "cell")
            view.addSubview(contentCollectionView)
            contentCollectionView.snp.makeConstraints({ (make) in
                make.top.equalTo(headerView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            })
        }
    }
}

extension NewsViewController: HeaderViewDelegate {
    func categoryHeaderView(headerView: HeaderView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        contentCollectionView.scrollAffectToNoOnce()
        contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

extension NewsViewController: ContentCollectionViewDelegate {
    func contentCollectionView(_ contentView: ContentCollectionView, didShowViewWith index: Int) {
        headerView.selectTitle(of: index)
    }
    
    func contentCollectionView(_ contentView: ContentCollectionView, didScrollFrom fromIndex: Int, to toIndex: Int, scale: Float) {
        headerView.adjustTitle(from: fromIndex, to: toIndex, scale: scale)
    }
}

extension NewsViewController: ContentCollectionViewDataSource {
    func numberOfItems(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsContentCell
        
        if let cell = cell {
            cell.title = categories[indexPath.item]
            return cell
        }
        
        cell = NewsContentCell()
        cell!.title = categories[indexPath.item]
        return cell!
    }
}

