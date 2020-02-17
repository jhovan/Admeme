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
    
    var cellIndex: Int?
    var verTodoView: VerTodoCollectionViewController?
    var fileURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fileURL = self.verTodoView!.cellItems[cellIndex!]
        self.imageView.image = UIImage(contentsOfFile: self.fileURL!.path)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    
    @IBAction func starButton(_ sender: Any) {
    }
    
    
    @IBAction func removeButton(_ sender: Any) {
        ImageManager.removeImage(fileURL: self.fileURL!)
        self.verTodoView?.cellItems.remove(at: cellIndex!)
        dismiss(animated: true, completion: nil)
    }
    


}
