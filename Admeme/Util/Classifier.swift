//
//  Classifier.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 20/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation

class Classifier {
    
    // ALWAYS returns non empty arrays
    static func getGroups() -> [[String]] {
        let urls =  ImageManager.getAllFilesUrls()
        var groups: [[String]] = []
        for url in urls {
            groups.append([url.path])
        }
        return groups
    }
    
}
