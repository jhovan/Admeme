//
//  ImageManager.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 14/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation
import UIKit

// Manages image files within the documents folder
class ImageManager {
    
    // Save an image with a given name
    static func saveImage(imageName: String, image: UIImage) -> URL?{
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}

        var fileName = imageName
        var fileURL = documentsDirectory.appendingPathComponent(fileName)

        while FileManager.default.fileExists(atPath: fileURL.path) {
            fileName = fileName.replacingOccurrences(of: ".", with: "(1).")
            print(fileName)
            fileURL = documentsDirectory.appendingPathComponent(fileName)
        }

        // reduces image quality to improve performance
        guard let data = image.jpegData(compressionQuality: 0.0) else { return nil}

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error {
            print("error saving file with error", error)
        }
        
        return nil
    }
    
    // saves an image with a random generated name
    static func saveImage(image: UIImage) -> URL? {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}

        var fileURL: URL
        repeat {
            let fileName = UUID().uuidString + ".jpg"
            fileURL = documentsDirectory.appendingPathComponent(fileName)
        }
        while FileManager.default.fileExists(atPath: fileURL.path)
        

        guard let data = image.jpegData(compressionQuality: 1) else { return nil}

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error {
            print("error saving file with error", error)
        }
        
        return nil
    }

    
    // Loads an image from documents with the specified name
    static func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image

        }

        return nil
    }
    
    // removes an image with a given URL
    static func removeImage(fileURL: URL) {
        self.removeImage(filePath: fileURL.path)
        
    }
    
    // removes an image with a given filepath
    static func removeImage(filePath: String) {
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }
    }
    
    
    // returns an array with all file URLs inside documents
    static func getAllFileUrls() -> [URL] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            return fileURLs
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
            return []
        }
    }
    
    // returns an array with all filepaths inside documents
    static func getAllFilepaths() -> [String] {
        let urls = getAllFileUrls()
        var filepaths:[String] = []
        for url in urls {
            filepaths.append(url.path)
        }
        return filepaths
    }
    
    // loads an image with a given URL
    static func loadImageFromDiskWith(imageUrl: URL) -> UIImage? {
            return UIImage(contentsOfFile: imageUrl.path)
    }
    
    // removes all images from documents
    static func removeAllFiles() {
        let urls = getAllFileUrls()
        for url in urls {
            removeImage(fileURL: url)
        }
    }
}
