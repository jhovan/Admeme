//
//  ImageCollectionViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 15/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit
import Photos


class VerTodoCollectionViewController: ImageGridWithDetail, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(
        self,
        selector:#selector(updateFromDocuments),
        name: UIApplication.didBecomeActiveNotification,
        object: nil)
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker?.sourceType = .photoLibrary
        self.imagePicker?.delegate = self
    }
    
    @objc func updateFromDocuments() {
        // check for imported new files
        let userDefaults = UserDefaults(suiteName: Constants.GROUP)
        if let sharedArray = userDefaults?.object(forKey: Constants.SHARE_KEY) as? [Data] {
           for imageData in sharedArray {
               _ = ImageManager.saveImage(image: UIImage(data: imageData)!)
           }
           userDefaults?.removeObject(forKey: Constants.SHARE_KEY)
        }
        self.viewWillAppear(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // load files from documents
        self.cellItems = ImageManager.getAllFilepaths()
        super.viewWillAppear(animated)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        
        // Saves the image to Documents
        var url: URL?
        url = ImageManager.saveImage(image: image)
                    
        // Removes the image from Photos in case there is authorization
        let status = PHPhotoLibrary.authorizationStatus()
    
        if status == .authorized {
            
            let imageAsset:PHAsset = info[UIImagePickerController.InfoKey.phAsset] as! PHAsset
            let enumeration: NSArray = [imageAsset]
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets(enumeration)
            }, completionHandler: {success, error in
                print(success ? "Success removing from Photos" :  "Error removing from Photos" )
            })
        }

        
        if let url = url {
            self.cellItems.append(url.path)
        }
        
        self.collectionView.reloadData()

        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func openPhotos(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization({_ in})
        self.present(self.imagePicker!, animated: true, completion: nil)
    }
    

}
