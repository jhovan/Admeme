//
//  ImageCollectionViewController.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 15/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit
import Photos


class VerTodoCollectionViewController: ImageGridWithSegue, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker?.sourceType = .photoLibrary
        self.imagePicker?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let urls = ImageManager.getAllFilesUrls()
        
        self.cellItems = []
        for url in urls {
            self.cellItems.append(url.path)
        }
        super.viewWillAppear(animated)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        
        // Se almacena en Documents
        var url: URL?
            
        
        // Borramos la foto de la galeria
        let status = PHPhotoLibrary.authorizationStatus()
    
        if status == .authorized {
            
            let imageAsset:PHAsset = info[UIImagePickerController.InfoKey.phAsset] as! PHAsset
            let enumeration: NSArray = [imageAsset]
            
            url = ImageManager.saveImage(imageName: imageAsset.value(forKey: "filename") as! String, image: image)
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets(enumeration)
            }, completionHandler: {success, error in
                print(success ? "Success" :  "Error" )
            })
        }
        else {
            url = ImageManager.saveImage(imageName: String("\(cellItems.count).jpg"), image: image)
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
