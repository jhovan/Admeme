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
    
    var fileURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(contentsOfFile: fileURL!.path)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    
    @IBAction func starButton(_ sender: Any) {
    }
    
    
    @IBAction func removeButton(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
