//
//  ImageManagerTests.swift
//  AdmemeTests
//
//  Created by Jhovan Gallardo on 23/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import XCTest
@testable import Admeme

class ImageManagerTests: XCTestCase {
    
    var image: UIImage?
    var url: URL?
    
    override func setUp() {
        let bundle = Bundle(for: ImageManagerTests.self)
        self.image = UIImage(named: "perro", in: bundle, compatibleWith: nil)
        self.url = ImageManager.saveImage(image: self.image!)
    }

    override func tearDown() {
        ImageManager.removeImage(fileURL: self.url!)
    }

    func testSaveImageWithoutName() {
        let urlsBefore = ImageManager.getAllFileUrls()
        let newUrl = ImageManager.saveImage(image: self.image!)
        let urlsAfter =  ImageManager.getAllFileUrls()
        assert(urlsAfter.count > urlsBefore.count)
        assert(urlsAfter.contains(newUrl!))
    }
    
    func testSaveImageWithName() {
        let urlsBefore = ImageManager.getAllFileUrls()
        let newUrl = ImageManager.saveImage(imageName: "Test", image: self.image!)
        let urlsAfter =  ImageManager.getAllFileUrls()
        assert(urlsAfter.count > urlsBefore.count)
        assert(urlsAfter.contains(newUrl!))
    }
    
    func testRemoveExistentImage() {
        let urlsBefore = ImageManager.getAllFileUrls()
        ImageManager.removeImage(fileURL: self.url!)
        let urlsAfter =  ImageManager.getAllFileUrls()
        assert(urlsAfter.count < urlsBefore.count)
        assert(!urlsAfter.contains(self.url!))
    }
    
    func testRemoveInexistentImage() {
        ImageManager.removeImage(fileURL: self.url!)
        let urlsBefore = ImageManager.getAllFileUrls()
        ImageManager.removeImage(fileURL: self.url!)
        let urlsAfter =  ImageManager.getAllFileUrls()
        assert(urlsAfter.count == urlsBefore.count)
        assert(!urlsAfter.contains(self.url!))
    }
    
    func testLoadFromDisk() {
        XCTAssertNotNil(ImageManager.loadImageFromDiskWith(imageUrl: self.url!))
    }

}
