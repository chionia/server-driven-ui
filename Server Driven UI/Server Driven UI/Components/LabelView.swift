//
//  LabelView.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 30/05/2023.
//

import UIKit

class UIElementViewCell: UITableViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LabelView: UIElementViewCell {

    static let reuseIdentifier = "LabelViewCell"
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textAlignment = .left
            label.font = UIFont(name:"Futura-Bold", size: 24.0)
        }
    }
    
    public func configure(textData: TextData?, backgroundColor: String? = nil) {
        label.text = textData?.text
        label.backgroundColor = .clear
        self.backgroundColor = .clear
        if let textColor = textData?.textColor {
            label.textColor = hexStringToUIColor(hex: textColor)
        }
        if let backgroundColor = backgroundColor {
            label.backgroundColor = .clear
            self.backgroundColor =  hexStringToUIColor(hex: backgroundColor)
        }
        if let textSize = textData?.textSize {
            label.font = UIFont(name:"Futura-Bold", size: CGFloat(textSize))
        }
    }
}

func hexStringToUIColor(hex: String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
