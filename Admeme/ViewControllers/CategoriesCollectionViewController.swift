//
//  CategoriasCollectionViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 20/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit


class CategoriesCollectionViewController: ImageGrid {

    var groups: [[String]] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.groups.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groups = Classifier.getGroups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.filePath = self.groups[indexPath.row][0]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupSegue" {
            let viewController: CategoryCollectionViewController = segue.destination as! CategoryCollectionViewController
            let indexPath: IndexPath = self.collectionView.indexPathsForSelectedItems![0]
            viewController.cellItems = self.groups[indexPath.row]
       }
    }

    @IBAction func updateButton(_ sender: Any) {
        self.groups = Classifier.getGroups()
        self.collectionView.reloadData()
    }
    

}
