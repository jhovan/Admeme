//
//  ImageGridExtension.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 18/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation

extension ImageGrid {
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "detailViewSegue" {
           let viewController: DetailViewController = segue.destination as! DetailViewController
           let indexPath: IndexPath = self.collectionView.indexPathsForSelectedItems![0]
           viewController.cellIndex = indexPath.row
           viewController.imageGridView = self
       }
    }
}
