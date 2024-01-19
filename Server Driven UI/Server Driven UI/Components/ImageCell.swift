//
//  ImageCell.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 31/05/2023.
//

import Foundation
import UIKit

class ImageCell: UIElementViewCell {
    static let reuseIdentifier = "ImageCell"
    
    @IBOutlet weak var thisImageView: UIImageView! {
        didSet {
            thisImageView.contentMode = .scaleAspectFill
        }
    }

    public func configure(image: UIImage) {
        thisImageView.image = image
    }
}
