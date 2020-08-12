//
//  File.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String , font : UIFont ,numberOfLines : Int = 1 ,fontcolor : UIColor? = nil ){
        self.init(frame:.zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        if let fontColor = fontcolor {
            self.textColor = fontColor
        }
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat , image : UIImage? = nil) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        if let image = image {
            self.image = image
        }
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
