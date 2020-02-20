//
//  ImageGridWithSegue.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 18/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit


class ImageGridWithDetail: ImageGrid {
    
    var cellItems: [String] = []
    var selectFlag: Bool = false
    
    @IBOutlet weak var selectButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    @IBAction func selectButton(_ sender: Any) {
        changeSelectOption()
    }
    
    func changeSelectOption() {
        self.shareButton.isEnabled = false
        self.removeButton.isEnabled = false
        self.selectFlag = !self.selectFlag
        self.tabBarController?.tabBar.isHidden = self.selectFlag
        self.navigationController?.isToolbarHidden = !self.selectFlag
        self.collectionView.allowsSelection = false
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = self.selectFlag
        selectButton.title = self.selectFlag ? "Cancelar" : "Seleccionar"
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let indexPaths = self.collectionView.indexPathsForSelectedItems
        var images: [UIImage] = []
        for indexPath in indexPaths! {
            images.append(UIImage(contentsOfFile: self.cellItems[indexPath.row])!)
        }
        let ac = UIActivityViewController(activityItems: images as [Any], applicationActivities: nil)
        present(ac, animated: true)
        changeSelectOption()
    }
    
    @IBAction func removeButton(_ sender: Any) {
        removeSelection()
    }
    
    func removeSelection() {
        let indexPaths = self.collectionView.indexPathsForSelectedItems
        var favorites: [String] = UserDefaults.standard.stringArray(forKey: Constants.FAVORITES_KEY) ?? []
        let previousCellItems = self.cellItems
        for indexPath in indexPaths! {
            let cellIndex = indexPath.row
            let filePath = previousCellItems[cellIndex]
            let fileName = URL(fileURLWithPath: filePath).lastPathComponent
            ImageManager.removeImage(filePath: filePath)
            self.cellItems.removeAll(where: {$0 == filePath})
            if favorites.contains(fileName) {
                favorites.removeAll(where: {$0 == fileName})
            }
        }
        self.collectionView.reloadData()
        UserDefaults.standard.set(favorites, forKey: Constants.FAVORITES_KEY)
        changeSelectOption()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.collectionView.indexPathsForSelectedItems?.count ?? 0 > 0 {
            self.shareButton.isEnabled = true
            self.removeButton.isEnabled = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if self.collectionView.indexPathsForSelectedItems?.count ?? 0 == 0 {
            self.shareButton.isEnabled = false
            self.removeButton.isEnabled = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.cellItems.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
