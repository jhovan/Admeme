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
    
    
    var item: CellModel? {
        didSet {
            self.configure(item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ item: CellModel?) {
        if let model = item {
            self.imageView.image = model.image
        }
    }
    
}
