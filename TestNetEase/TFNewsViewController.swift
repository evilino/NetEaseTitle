//
//  TFNewsViewController.swift
//  TestNetEase
//
//  Created by 田腾飞 on 2016/12/24.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit

protocol TFNewsViewControllerDelegate: NSObjectProtocol {
    func contentViewController(viewController: TFNewsViewController, scrollTo index: Int)
}

class TFNewsViewController: UIViewController {
    var headerView: TFCategoryHeaderView!
    var contentView: UICollectionView!
    weak var delegate: TFNewsViewControllerDelegate?
    var currentOffsetX: Float = 0.0
    var toIndex = 0
    var oldIndex = 0
    var isTapSelected = false
    lazy var categories: [String] = {
        return ["头条", "独家", "NBA", "社会", "历史", "军事", "航空", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        do {
            headerView = TFCategoryHeaderView()
            headerView.delegate = self
            view.addSubview(headerView)
            headerView.snp.makeConstraints({ [unowned self] (make) in
                make.left.right.equalTo(self.view)
                make.height.equalTo(40)
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            })
            headerView.categories = categories
        }
        
        do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 104)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .horizontal
            
            contentView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
            contentView.collectionViewLayout = flowLayout
            contentView.register(TFCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            contentView.backgroundColor = UIColor.red
            contentView.dataSource = self
            contentView.delegate = self
            contentView.isPagingEnabled = true
            contentView.showsVerticalScrollIndicator = false
            contentView.showsHorizontalScrollIndicator = false
            view.addSubview(contentView)
            contentView.snp.makeConstraints({ (make) in
                make.top.equalTo(headerView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            })
        }
    }

}

extension TFNewsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TFCollectionViewCell
        guard let currentCell = cell else {
            return cell!
        }
        
        currentCell.title = categories[indexPath.item]
        currentCell.backgroundColor = UIColor(red: CGFloat(Float.random()), green: CGFloat(Float.random()), blue: CGFloat(Float.random()), alpha: 1)
        
        return currentCell
    }
}

extension TFNewsViewController: UICollectionViewDelegate {
    
}

extension TFNewsViewController: UIScrollViewDelegate {
    /// 开始拖拽的时候
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentOffsetX = Float(scrollView.contentOffset.x)
        isTapSelected = false
        currentOffsetX = Float(scrollView.contentOffset.x)
    }
    
    /// 滑动过程中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isTapSelected {
            return
        }
        
        let scale = Float(scrollView.contentOffset.x).truncatingRemainder(dividingBy: Float(UIScreen.main.bounds.width)) / Float(UIScreen.main.bounds.width)
        if scale == 0.0 {
            return
        }
        
        let index = Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width)
        let diff = Float(scrollView.contentOffset.x) - currentOffsetX
        
        if diff > 0.0 { // 向右滑动
            toIndex = index + 1
            oldIndex = index
        } else { //向左滑动
            oldIndex = index + 1
            toIndex = index
        }
        
        if toIndex > categories.count - 1 || toIndex < 0 || oldIndex > categories.count - 1 {
            return
        }
        
        headerView.adjustTitle(from: oldIndex, to: toIndex, scale: scale)
    }
    
    /// 滑动停止
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isTapSelected {
            return
        }

        currentOffsetX = Float(scrollView.contentOffset.x)
        toIndex = Int(currentOffsetX / Float(UIScreen.main.bounds.width))
        if toIndex > categories.count - 1 || toIndex < 0 {
            return
        }
        headerView.selectTitle(of: toIndex)
    }
}

extension TFNewsViewController: TFCategoryHeaderViewDelegate {
    internal func categoryHeaderView(headerView: TFCategoryHeaderView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        isTapSelected = true
        contentView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

