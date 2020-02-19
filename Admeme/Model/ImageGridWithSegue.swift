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
    var selectFlag: Bool = false
    
    @IBAction func selectButton(_ sender: Any) {
        self.selectFlag = !self.selectFlag
        self.tabBarController?.tabBar.isHidden = self.selectFlag
        self.navigationController?.isToolbarHidden = !self.selectFlag
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    @IBAction func removeButton(_ sender: Any) {
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.cellItems.count
    }
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "detailViewSegue" {
            return !self.selectFlag
        }
        return true
    }
}
