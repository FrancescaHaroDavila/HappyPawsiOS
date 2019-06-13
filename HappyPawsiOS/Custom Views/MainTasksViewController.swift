//
//  MainTasksViewController.swift
//  HappyPawsiOS
//
//  Created by Carlo Aguilar on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class MainTasksViewController: UIViewController {
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    
    private var indexOfCellBeforeDragging = 0
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return tasksCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

extension MainTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "Pet1", for: indexPath) as? PetCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "Pet2", for: indexPath) as? PetCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        if indexPath.row == 2 {
            guard let cell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "Pet3", for: indexPath) as? PetCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    private func configureCollectionViewLayoutItemSize() {
        var inset: CGFloat
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
            inset = (self.view.frame.width * (1 - 0.99))/2
        }else {
            inset = 20
        }
        self.collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
            self.collectionViewFlowLayout.itemSize = CGSize(width: self.tasksCollectionView.collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: self.tasksCollectionView.collectionViewLayout.collectionView!.frame.size.height - inset * 1.2)
            self.collectionViewFlowLayout.minimumLineSpacing = 45
        }else {
            self.collectionViewFlowLayout.itemSize = CGSize(width: self.tasksCollectionView.collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: self.tasksCollectionView.collectionViewLayout.collectionView!.frame.size.height - inset/2)
            self.collectionViewFlowLayout.minimumLineSpacing = 10
        }
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = self.tasksCollectionView.collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = self.tasksCollectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let dataSourceCount = collectionView(self.tasksCollectionView!, numberOfItemsInSection: 0)
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = self.indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = self.indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        if didUseSwipeToSkipCell {
            let snapToIndex = self.indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = self.collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            self.tasksCollectionView.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
