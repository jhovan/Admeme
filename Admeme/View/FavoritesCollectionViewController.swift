//
//  FavoritesCollectionViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class FavoritesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

      let cellsByRow: CGFloat = 3
       var cellItems: [String] = []
       var imagePicker: UIImagePickerController?

       override func viewDidLoad() {
           super.viewDidLoad()

           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false

           // Register cell classes
           //self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

           // Do any additional setup after loading the view.
           
           let urls = ImageManager.getAllFilesUrls()
           
           for url in urls {
               cellItems.append(url.path)
           }
           
       }
       
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
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
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
       
       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "detailViewSegue" {
               let viewController: DetailViewController = segue.destination as! DetailViewController
               let indexPath: IndexPath = self.collectionView.indexPathsForSelectedItems![0]
               viewController.cellIndex = indexPath.row
               //viewController.verTodoView = self
           }
       }
       



       // MARK: UICollectionViewDelegate

       /*
       // Uncomment this method to specify if the specified item should be highlighted during tracking
       override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
           return true
       }
       */

       /*
       // Uncomment this method to specify if the specified item should be selected
       override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
           return true
       }
       */

       /*
       // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
       override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
           return false
       }

       override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
           return false
       }

       override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
       
       }
       */
       

}
