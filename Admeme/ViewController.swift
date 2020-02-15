//
//  ViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 13/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var testImageBox: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageManager.saveImage(imageName: "perro.jpg", image: UIImage(named: "perro")!)
        ImageManager.saveImage(imageName: "gato.jpg", image: UIImage(named: "gato")!)
        
    }


}

