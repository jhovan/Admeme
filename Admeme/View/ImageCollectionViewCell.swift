//
//  ImageCollectionViewCell.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 15/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var fileURL: URL? {
        didSet {
            self.configure(fileURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ fileURL: URL?) {
        if let fileURL = fileURL {
            self.imageView.image = UIImage(contentsOfFile: fileURL.path)!
        }
    }
    
}
