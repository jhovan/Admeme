//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Jhovan Gallardo on 14/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices


class ShareViewController: ImageGrid {
    
    
    var selectedImages: [UIImage] = []
    var imagesData: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageImages()
    }
    
    // Removes previously stored data from disk
    @IBAction func cancelButton(_ sender: Any) {
        let userDefaults = UserDefaults(suiteName: Constants.GROUP)
        userDefaults?.removeObject(forKey: Constants.SHARE_KEY)
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    // Opens then main app
    @IBAction func addButton(_ sender: Any) {
        self.redirectToHostApp()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = selectedImages[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.selectedImages.count
    }
    
    // Opens the main app with an empty URL
    func redirectToHostApp() {
        let url = URL(string: "Admeme://")
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    
    // Stores selected images into UserDefaults group temporary
    func manageImages() {
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for (index, attachment) in (content.attachments!).enumerated() {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                
                attachment.loadItem(forTypeIdentifier: contentType, options: nil) { [weak self] data, error in
                    
                    if error == nil, let url = data as? URL, let this = self {
                        do {
                            
                            let rawData = try Data(contentsOf: url)
                            let rawImage = UIImage(data: rawData)
                            

                            let image = rawImage!
                            // reduces image quality to avoid memory issues
                            let imgData = image.jpegData(compressionQuality: 0.0)
                            
                            
                            self?.selectedImages.append(image)
                            self?.imagesData.append(imgData!)
                            
                            if index == (content.attachments?.count)! - 1 {
                                DispatchQueue.main.async {
                                    self!.collectionView.reloadData()
                                    let userDefaults = UserDefaults(suiteName: Constants.GROUP)
                                    
                                    userDefaults?.set(this.imagesData, forKey: Constants.SHARE_KEY)
                                    userDefaults?.synchronize()
                                }
                            }
                        }
                        catch let exp {
                            print("GETTING EXCEPTION \(exp.localizedDescription)")
                        }
                        
                    } else {
                        print("GETTING ERROR")
                        let alert = UIAlertController(title: "Error", message: "Error loading image", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Error", style: .cancel) { _ in
                            self?.dismiss(animated: true, completion: nil)
                        }
                        
                        alert.addAction(action)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

}
