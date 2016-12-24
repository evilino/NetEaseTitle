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
    var currentOffset: Float = 0.0
    var categories: [String] = ["头条", "独家", "NBA", "社会", "历史", "军事", "航空", "要闻", "娱乐", "财经", "趣闻","头条", "独家", "NBA", "社会", "历史"]
    
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
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TFCollectionViewCell
        guard let currentCell = cell else {
            return cell!
        }
        
        currentCell.backgroundColor = UIColor(red: CGFloat(Float.random()), green: CGFloat(Float.random()), blue: CGFloat(Float.random()), alpha: 1)
        return currentCell
    }
}

extension TFNewsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.contentViewController(viewController: self, scrollTo: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentOffset = Float(scrollView.contentOffset.x)
        print(currentOffset)
    }
}

extension TFNewsViewController: TFCategoryHeaderViewDelegate {
    internal func categoryHeaderView(headerView: TFCategoryHeaderView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        contentView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

