//
//  ImageGridWithSegue.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 18/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit


class ImageGridWithSegue: ImageGrid {
    
    var cellItems: [String] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.cellItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
       cell.filePath = self.cellItems[indexPath.row]
       return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "detailViewSegue" {
           let viewController: DetailViewController = segue.destination as! DetailViewController
           let indexPath: IndexPath = self.collectionView.indexPathsForSelectedItems![0]
           viewController.cellIndex = indexPath.row
           viewController.imageGridView = self
       }
    }
}
