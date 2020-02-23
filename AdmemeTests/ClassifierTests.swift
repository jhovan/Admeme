//
//  ClassifierTests.swift
//  AdmemeTests
//
//  Created by Jhovan Gallardo on 23/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import XCTest
@testable import Admeme

class ClassifierTests: XCTestCase {

    let bundle = Bundle(for: ImageManagerTests.self)
    
    override func setUp() {
        ImageManager.removeAllFiles()
    }

    func testGroupsWithoutFiles() {
        let groups = Classifier.generateGroups()
        assert(groups.isEmpty)
    }
    
    func testGroupsWithDifferentImages() {
        var image = UIImage(named: "perro", in: bundle, compatibleWith: nil)
        _ = ImageManager.saveImage(image: image!)
        image = UIImage(named: "gato", in: bundle, compatibleWith: nil)
        _ = ImageManager.saveImage(image: image!)
        let groups = Classifier.generateGroups()
        assert(groups.count == 2)
        assert(union(groups: groups).count == ImageManager.getAllFileUrls().count)
    }
    
    func testGroupsWithSameImage() {
        var image = UIImage(named: "perro", in: bundle, compatibleWith: nil)
        _ = ImageManager.saveImage(image: image!)
        image = UIImage(named: "perro", in: bundle, compatibleWith: nil)
        _ = ImageManager.saveImage(image: image!)
        let groups = Classifier.generateGroups()
        assert(groups.count == 1)
        assert(union(groups: groups).count == ImageManager.getAllFileUrls().count)
        
    }
    
    // returns the union of an array of arrays of stringsx
    func union(groups: [[String]]) -> [String] {
        var union:[String] = []
        for group in groups {
            union += group
        }
        return union
    }
    
    
}
