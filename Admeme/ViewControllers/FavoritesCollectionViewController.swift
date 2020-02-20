//
//  FavoritesCollectionViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 17/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit


class FavoritesCollectionViewController: ImageGridWithDetail {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.

       
    }
       
    
    override func viewWillAppear(_ animated: Bool) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        if let favorites =  UserDefaults.standard.dictionary(forKey: Constants.FAVORITES_KEY) {
            self.cellItems = Array(favorites.keys).map({ documentsDirectory.appendingPathComponent($0).path})
        }
        super.viewWillAppear(animated)
    }

}
