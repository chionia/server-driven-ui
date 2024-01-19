//
//  CollectionView.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 30/05/2023.
//

import Foundation
import UIKit

class CollectionView: UIElementViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    var elements = [CollectionData]()
    var isSmall = false
    
    static let reuseIdentifier = "CollectionViewCell"
    
    func heightFix() {
        if isSmall {
            heightConstant.constant = (self.frame.size.width / 2) - 50
        } else {
            heightConstant.constant = (self.frame.size.width / 2)
        }
        layoutIfNeeded()
    }
    
    public func configure(elements: [CollectionData], isSmall: Bool = false) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        self.collectionView.bounces = true
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        
        self.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: String(describing: CollectionViewCell.self),
                                      bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        self.collectionView.collectionViewLayout = layout

        self.elements = elements
        self.isSmall = isSmall
        
        heightFix()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    var imageViews: [String:UIImage] = [:]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell;
        
        let info = elements[indexPath.row]
       
        cell.configure(image: getImage(imageURL: info.imageURL ?? ""), textData: info.textData)
        
        return cell;
    }

    func getImage(imageURL: String) -> UIImage {
        if let im = imageViews[imageURL] {
            return im
        }
        
        var img: UIImage = UIImage()
        
        if let url = URL(string: imageURL) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    img = image
                    imageViews[imageURL] = image
                }
            }
        }
        return img
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isSmall {
            let width = (self.frame.size.width / 2) - 90
            let height = width
            return CGSize(width: width, height: height)
        } else {
            let width = (self.frame.size.width / 2) - 40
            let height = width
            return CGSize(width: width, height: height)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
