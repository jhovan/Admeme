//
//  ImageCollectionViewCell.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 15/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit


// Defines image cells behaviour 
class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var originalBackgroundColor: UIColor?
    
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
            self.originalBackgroundColor = self.backgroundColor
            self.imageView.image = UIImage(contentsOfFile: filePath) ?? UIImage(systemName:"exclamationmark.square.fill")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.imageView.alpha = 0.5
                self.backgroundColor = .systemBlue
                
            }
            else {
                self.imageView.alpha = 1
                self.backgroundColor = self.originalBackgroundColor
            }
        }
    }
    
}
