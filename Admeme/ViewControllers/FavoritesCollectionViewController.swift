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

    }
       
    
    override func viewWillAppear(_ animated: Bool) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        if let favorites =  UserDefaults.standard.stringArray(forKey: Constants.FAVORITES_KEY) {
            self.cellItems = favorites.map({ documentsDirectory.appendingPathComponent($0).path})
        }
        super.viewWillAppear(animated)
    }

}
