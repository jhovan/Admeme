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
        asynchronousRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
        asynchronousRefreshing()
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

    

    func asynchronousRefreshing() {
        
        // If a file was removed, it is removed manually from the groups
        let filepaths = ImageManager.getAllFilepaths()
        for i in stride(from: 0, through: self.groups.count - 1, by: 1) {
            for path in self.groups[i] {
                if !filepaths.contains(path) {
                    self.groups[i].removeAll(where: {$0 == path})
                }
            }
        }
        self.groups.removeAll(where:{$0.isEmpty})
        self.collectionView.reloadData()
        
        var pathsFromGroups:[String] = []
        for group in self.groups {
            pathsFromGroups += group
        }
        
        // If there are more files in documents than in the groups
        // the groups have to be created again
        if filepaths.count > pathsFromGroups.count {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.hidesWhenStopped = true
            indicator.startAnimating()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
            let dataOperation = BlockOperation {
                self.groups = Classifier.getGroups()
            }
            let UIOperation = BlockOperation {
                self.collectionView.reloadData()
                indicator.stopAnimating()
            }
            UIOperation.addDependency(dataOperation)
            let queue = OperationQueue()
            queue.addOperation (dataOperation)
            OperationQueue.main.addOperation(UIOperation)
        }
    }
}
