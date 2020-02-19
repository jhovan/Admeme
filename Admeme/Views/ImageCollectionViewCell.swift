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
    
    
    var filePath: String? {
        didSet {
            self.configure(filePath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ filePath: String?) {
        if let filePath = filePath {
            self.imageView.image = UIImage(contentsOfFile: filePath)!
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.imageView.alpha = 0.3
            }
            else {
                self.imageView.alpha = 1
            }
        }
    }
    
}
