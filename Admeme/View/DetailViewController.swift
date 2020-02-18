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
    var imageGridView: ImageGrid?
    var filePath: String?
    var favourites: [String: Any]? = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favourites =  UserDefaults.standard.dictionary(forKey: Constants.FAVORITES_KEY) {
            self.favourites = favourites
        }

        self.filePath = self.imageGridView!.cellItems[cellIndex!]
        if ((self.favourites?.keys.contains(filePath!))!) {
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }
        self.imageView.image = UIImage(contentsOfFile: self.filePath!)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    
    @IBAction func starButton(_ sender: Any) {
        if ((self.favourites?.keys.contains(filePath!))!) {
            self.favourites?.removeValue(forKey: filePath!)
            UserDefaults.standard.set(self.favourites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star"), for: .normal)
        }
        else {
            self.favourites?.updateValue(1, forKey: filePath!)
            UserDefaults.standard.set(self.favourites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }

    }
    
    
    @IBAction func removeButton(_ sender: Any) {
        ImageManager.removeImage(filePath: self.filePath!)
        self.imageGridView?.cellItems.remove(at: cellIndex!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
