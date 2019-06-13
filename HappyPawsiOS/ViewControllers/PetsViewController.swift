//
//  PetsViewController.swift
//  HappyPawsiOS
//
//  Created by Bryam  on 6/12/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {

    @IBOutlet weak var ownersCollectionView: UICollectionView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var petProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}


extension PetsViewController {
    func setupUI() {
        let profileImageSize = petProfileImageView.bounds.width
        petProfileImageView.layer.cornerRadius = profileImageSize/2
        petProfileImageView.layer.borderWidth = 1.0
        petProfileImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

extension PetsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OwnerCell", for: indexPath)
        return cell
    }
}

extension PetsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems: CGFloat = 3.0
        let collectionWidth = collectionView.bounds.width
        let cellSize = (collectionWidth / numberOfItems) - 10
        return CGSize(width: cellSize, height: cellSize)
    }
}

