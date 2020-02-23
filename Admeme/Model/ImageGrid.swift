//
//  ImageGridProtocol.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

// Defines format and basic behaviour 

class ImageGrid: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "ImageCell"

    let cellsByRow: CGFloat = 3

    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    
    override func viewWillAppear(_ animated: Bool) {
       self.collectionView.reloadData()
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }


    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
       let dimension = (self.view.frame.size.width - 3 * (self.cellsByRow - 1))/self.cellsByRow
       return CGSize(width: dimension, height: dimension)
       
    }

    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 3.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
       collectionViewLayout: UICollectionViewLayout,
                       minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 3.0
    }


}
