//
//  EmojeCVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/4/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit

class EmojeCVC: UICollectionViewCell {
    static let reuseIdentifier = "Emoji-collectionView-cell-reuse-identifier"
    
    let label = UILabel(text: "", font: .systemFont(ofSize: 40))
    var title : String? {
        didSet{
            configure()
        }
    }
    fileprivate func configure() {
        contentView.addSubview(label)
        label.centerInSuperview()
        if let title = self.title {
            label.text = title
        }
        self.layer.cornerRadius = contentView.bounds.width / 2
        //        clipsToBounds = true
        backgroundColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
