//
//  ImageGridProtocol.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class ImageGrid: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "ImageCell"

    let cellsByRow: CGFloat = 3
    var cellItems: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
       self.collectionView.reloadData()
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of items
       return self.cellItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
       cell.filePath = self.cellItems[indexPath.row]
       return cell
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
