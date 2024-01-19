//
//  CollectionViewCell.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 30/05/2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textAlignment = .left
            label.font = UIFont(name:"Futura-Medium", size: 14.0)
        }
    }
    
    func configure(image: UIImage, textData: TextData?) {
        imageView.image = image
        label.text = textData?.text
        if let textColor = textData?.textColor {
            label.textColor = hexStringToUIColor(hex: textColor)
        }
        if let textSize = textData?.textSize {
            label.font = UIFont(name:"Futura-Medium", size: CGFloat(textSize))
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tapGestureRecognizer)
            
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.addGestureRecognizer(longPressRecognizer)
        
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
        
    @objc func tapped(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
            self.alpha = 0.8
        }) { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
               self.transform = .identity
                self.alpha = 1
           })
        }
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
//            self.alpha = 0.8
//        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
                self.alpha = 0.8
            })
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let  _ = touches.first {
            UIView.animate(withDuration: 0.2, animations: {
               self.transform = .identity
                self.alpha = 1
           })
        }
    }
}
