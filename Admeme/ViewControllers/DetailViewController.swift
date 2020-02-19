//
//  DetailViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var scrollView: ImageZoomView!
    
    @IBOutlet weak var starButton: UIButton!
    
    var cellIndex: Int?
    var imageGridView: ImageGridWithSegue?
    var filePath: String?
    var favorites: [String: Any]? = [:]
    var fileName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favorites =  UserDefaults.standard.dictionary(forKey: Constants.FAVORITES_KEY) {
            self.favorites = favorites
        }
        self.filePath = self.imageGridView!.cellItems[cellIndex!]
        self.fileName =  URL(fileURLWithPath: self.filePath!).lastPathComponent
        if ((self.favorites?.keys.contains(self.fileName!))!) {
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }
        self.scrollView.setup(image: UIImage(contentsOfFile: self.filePath!))
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        let items = [UIImage(contentsOfFile: self.filePath!)]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    @IBAction func starButton(_ sender: Any) {
        if ((self.favorites?.keys.contains(self.fileName!))!) {
            self.favorites?.removeValue(forKey: self.fileName!)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star"), for: .normal)
        }
        else {
            self.favorites?.updateValue(1, forKey: self.fileName!)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }

    }
    
    
    @IBAction func removeButton(_ sender: Any) {
        ImageManager.removeImage(filePath: self.filePath!)
        self.imageGridView?.cellItems.remove(at: cellIndex!)
        if ((self.favorites?.keys.contains(self.fileName!))!) {
            self.favorites?.removeValue(forKey: self.fileName!)
            UserDefaults.standard.set(self.favorites, forKey: Constants.FAVORITES_KEY)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
