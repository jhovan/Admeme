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
    var imageGridView: ImageGridWithDetail?
    var filePath: String?
    var favorites: [String]? = []
    var fileName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let favorites =  UserDefaults.standard.stringArray(forKey: Constants.FAVORITES_KEY) {
            self.favorites = favorites
        }
        self.filePath = self.imageGridView!.cellItems[cellIndex!]
        self.fileName =  URL(fileURLWithPath: self.filePath!).lastPathComponent
        if ((self.favorites?.contains(self.fileName!))!) {
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }
        self.imageView.image = UIImage(contentsOfFile: self.filePath!)
    }
    
    // If the file is inexistent, removes trash and dismisses the view
    override func viewWillAppear(_ animated: Bool) {
        if self.imageView.image == nil {
            removeCompletely()
        }
    }
    
    // Allows to share the image
    @IBAction func shareButton(_ sender: Any) {
        let items = [UIImage(contentsOfFile: self.filePath!)]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    // Adds and removes image from favorites
    @IBAction func starButton(_ sender: Any) {
        if ((self.favorites?.contains(self.fileName!))!) {
            self.favorites?.removeAll(where: {$0 == self.fileName!})
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star"), for: .normal)
        }
        else {
            self.favorites?.append(self.fileName!)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }

    }
    
    
    @IBAction func removeButton(_ sender: Any) {
        removeCompletely()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Removes a file safely
    func removeCompletely() {
        ImageManager.removeImage(filePath: self.filePath!)
        self.imageGridView?.cellItems.remove(at: cellIndex!)
        if ((self.favorites?.contains(self.fileName!))!) {
            self.favorites?.removeAll(where: {$0 == self.fileName!})
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
        }
        dismiss(animated: true, completion: nil)
    }

}
