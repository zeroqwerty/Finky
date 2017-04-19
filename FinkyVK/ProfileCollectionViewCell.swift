//
//  ProfileCollectionViewCell.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 19.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var TextCell: UILabel!
    @IBOutlet weak var CountCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ImageCell.layer.cornerRadius = 3
    }

    func configureCell(type: String, image: String?, text: String, count: String) {
        
        if let image = image {
            ImageCell.kf.setImage(with: URL(string: image))
        } else {
            switch type {
                case "friends":
                    ImageCell.image = UIImage(named: "ava-h")
                case "communities":
                    ImageCell.image = UIImage(named: "ava-h")
                case "photos":
                    ImageCell.image = UIImage(named: "ava-h")
                case "videos":
                    ImageCell.image = UIImage(named: "ava-h")
                case "files":
                    ImageCell.image = UIImage(named: "ava-h")
                default: break
            }
        }
        
        TextCell.text = text
        CountCell.text = count
    }
    
}
