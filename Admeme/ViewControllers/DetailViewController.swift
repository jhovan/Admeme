//
//  DetailViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var starButton: UIButton!
    
    var cellIndex: Int?
    var imageGridView: ImageGridWithSegue?
    var filePath: String?
    var favorites: [String: Any]? = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favorites =  UserDefaults.standard.dictionary(forKey: Constants.FAVORITES_KEY) {
            self.favorites = favorites
        }

        self.filePath = self.imageGridView!.cellItems[cellIndex!]
        if ((self.favorites?.keys.contains(filePath!))!) {
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }
        self.imageView.image = UIImage(contentsOfFile: self.filePath!)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    
    @IBAction func starButton(_ sender: Any) {
        let fileName =  URL(fileURLWithPath: filePath!).lastPathComponent
        if ((self.favorites?.keys.contains(fileName))!) {
            self.favorites?.removeValue(forKey: fileName)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star"), for: .normal)
        }
        else {
            self.favorites?.updateValue(1, forKey: fileName)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }

    }
    
    
    @IBAction func removeButton(_ sender: Any) {
        let fileName =  URL(fileURLWithPath: filePath!).lastPathComponent
        ImageManager.removeImage(filePath: self.filePath!)
        self.imageGridView?.cellItems.remove(at: cellIndex!)
        if ((self.favorites?.keys.contains(filePath!))!) {
            self.favorites?.removeValue(forKey: fileName)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
