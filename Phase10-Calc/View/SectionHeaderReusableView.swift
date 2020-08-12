//
//  HeaderView.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/10/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit

class SectionHeaderReusableView : UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: SectionHeaderReusableView.self)
    }
    let headerImagView : UIImageView = {
        let image = UIImageView(cornerRadius: 0)
        image.image = #imageLiteral(resourceName: "header phase")
        return image
    }()
    
    let headerTextImage : UIImageView = {
        let image = UIImageView(cornerRadius: 0)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "Phase 10 text ")
        return image
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        
        return button
    }()
    
    func configureView() {
       
         addSubview(headerImagView)
        headerImagView.translatesAutoresizingMaskIntoConstraints = false
        headerImagView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top: -100 , left: 0, bottom: 0, right: 0))
//        headerImagView.fillSuperView()
        
      
        addSubview(headerTextImage)
        headerTextImage.anchor(top: nil, leading: headerImagView.leadingAnchor, bottom: headerImagView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 100, right: 0))
        
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addButton)
        addButton.anchor(top: nil , leading: nil, bottom: headerImagView.bottomAnchor , trailing: headerImagView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 15 , right: 40))
        //
    }
    
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        backgroundColor = .none
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


