//
//  ImageManager.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 14/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    
    static func saveImage(imageName: String, image: UIImage) -> URL?{


        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}

        var fileName = imageName
        var fileURL = documentsDirectory.appendingPathComponent(fileName)

        while FileManager.default.fileExists(atPath: fileURL.path) {
            fileName = fileName.replacingOccurrences(of: ".", with: "(1).")
            print(fileName)
            fileURL = documentsDirectory.appendingPathComponent(fileName)
        }

        guard let data = image.jpegData(compressionQuality: 1) else { return nil}

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error {
            print("error saving file with error", error)
        }
        
        return nil
    }
    
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
    
    static func removeImage(fileURL: URL) {
        self.removeImage(filePath: fileURL.path)
        
    }
    
    static func removeImage(filePath: String) {
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }
    }
    
    
    static func getAllFilesUrls() -> [URL] {
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
    
    static func loadImageFromDiskWith(imageUrl: URL) -> UIImage? {
            return UIImage(contentsOfFile: imageUrl.path)
    }
}
