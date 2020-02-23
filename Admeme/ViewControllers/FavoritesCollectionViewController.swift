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
        
        // If there is favorites data, it loads it and verify it
        if var favorites =  UserDefaults.standard.stringArray(forKey: Constants.FAVORITES_KEY) {
            self.cellItems = favorites.map({ documentsDirectory.appendingPathComponent($0).path})
            
            // verifies that the files exist
            let filepaths =  ImageManager.getAllFilepaths()
            for item in self.cellItems {
                if !filepaths.contains("/private\(item)") {
                    print("Entro aqui")
                    self.cellItems.removeAll(where: {$0 == item})
                    let fileName = URL(fileURLWithPath: item).lastPathComponent
                    favorites.removeAll(where: {$0 == fileName})
                }
            }
            UserDefaults.standard.set(favorites, forKey: Constants.FAVORITES_KEY)
        }
        super.viewWillAppear(animated)
    }

}
