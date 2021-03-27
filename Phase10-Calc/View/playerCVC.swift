//
//  playerCVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/4/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit
import SwipeCellKit

class playerCVC: SwipeCollectionViewCell {
    static let reuseIdentifier = "player-collectionView-cell-reuse-identifier"
    
    fileprivate func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    let playerAvatarPhoto = UIImageView(cornerRadius: 0, image: UIImage(named: "man-\(Int.random(in: 0...4))"))
    
    
    let playerNameLabel = UILabel(text: "Ahmed", font: UIFont.init(name: "HiraMinProN-W3", size: 20) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor: #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1) )
    
    
    
    let phaseLabel = UILabel(text: "Phase: 2 ", font: UIFont(name: "HiraMinProN-W6", size: 17) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor: #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1))
    
    let pointsLabel = UILabel(text: "Points: ", font: UIFont(name: "HiraMinProN-W6", size: 17) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor: #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1))
    
    let setsLabel = UILabel(text:"One set of 4 + one run of 4", font: UIFont(name: "HiraMinProN-W3", size: 12) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 2, fontcolor: #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1))
    
    let rankingLabel = UILabel(text: "1 \n Ranking ", font: UIFont(name: "LucidaGrande-Bold", size: 17) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 2, fontcolor: #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1))
    
    let colorView = UIView()
    
    var isDragging : Bool?  {
        didSet{
            if let isDragging = isDragging {
                
                if isDragging {
//                    clipsToBounds = false
                    colorView.backgroundColor = #colorLiteral(red: 1, green: 0.2299106419, blue: 0.1861539483, alpha: 1)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.colorView.backgroundColor = .clear
                    }
                }
            }
        }
    }
    
   
    
    var playerItem : PlayerItem? {
        didSet{
            configureView()
        }
    }
    
//    let wrapperView : UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.04087775201, green: 0.120924212, blue: 0.2315217853, alpha: 1)
//        view.translatesAutoresizingMaskIntoConstraints  = false
//
//        return view
//    }()
    
    

    fileprivate func configureView() {
        self.layer.cornerRadius = 18
        
        self.swipeOffset = 100
        makeShadow()
        
//                clipsToBounds = true
        self.colorView.backgroundColor = .clear
        
        //#colorLiteral(red: 0.831372549, green: 0.7098039216, blue: 0.6901960784, alpha: 1)
        
            //#colorLiteral(red: 0.5254901961, green: 0.4588235294, blue: 0.662745098, alpha: 1) موف
            //#colorLiteral(red: 1, green: 0.8352941176, blue: 0.8039215686, alpha: 1) جبيلي
            //#colorLiteral(red: 0.6901960784, green: 0.7921568627, blue: 0.7803921569, alpha: 1) whit green
            //#colorLiteral(red: 0.968627451, green: 0.8392156863, blue: 0.7490196078, alpha: 1) rose
        //#colorLiteral(red: 0.9529411765, green: 0.7764705882, blue: 0.137254902, alpha: 1) yellow
        
        playerAvatarPhoto.contentMode = .scaleAspectFit
        playerAvatarPhoto.constrainWidth(constant: 76)
        playerAvatarPhoto.constrainHeight(constant: 75)
        
        
//        let fontColor  = #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.337254902, alpha: 1)
        var randomNum = Int.random(in: 0...4)
     
        playerNameLabel.textAlignment = .center
        playerNameLabel.text = playerItem?.name ?? "name"
        phaseLabel.text = "Phase: \(playerItem?.phase ?? 2)  "
        rankingLabel.text = "\(playerItem?.rank ?? 1) \n Ranking "
        pointsLabel.text = "Points: \(playerItem?.pionts ?? 50)"
        setsLabel.text = playerItem?.sets ?? "sets"
        if let image = playerItem?.image {
            playerAvatarPhoto.image = image
        }
        
        
        rankingLabel.textAlignment = .center
        
        let secondVerticalStack : UIStackView = {
            let stack = VerticalStackView(arrangedSubViewsArray: [phaseLabel , pointsLabel  , setsLabel , UIView() ], spacing: 6)
            return stack
        }()
        
        let horizontalStack = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubViewsArray: [playerAvatarPhoto , playerNameLabel ], spacing: 3) ,
            secondVerticalStack ,
            rankingLabel
        ])
        horizontalStack.spacing = 32
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        
      
        let customView : UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.7098039216, blue: 0.6901960784, alpha: 1)
            view.layer.cornerRadius =   18
            view.translatesAutoresizingMaskIntoConstraints  = false
            
            return view
        }()
        
//        self.contentView.addSubview(horizontalStack)
        contentView.addSubview(colorView)
        self.contentView.addSubview(customView)
//        self.contentView.addSubview(wrapperView)
        
//        wrapperView.addSubview(customView)
        customView.addSubview(horizontalStack)
        customView.fillSuperView()
//        wrapperView.fillSuperView()
        horizontalStack.fillSuperviewWithPadding(padding: .init(top: 0, left: 17, bottom: 0 , right: 17))
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.anchor(top: contentView.topAnchor, leading: nil , bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
        colorView.constrainWidth(constant: 300 )
//        horizontalStack.fillSuperviewWithPadding(padding: .init(top: 0, left: 17, bottom: 0 , right: 17))

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//   for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }

//   var playerName : String? {
//        didSet{
//            configureView()
//        }
//    }
//
//    var phase : Int? {
//        didSet{
//            configureView()
//        }
//    }
//
//    var points : Int? {
//        didSet{
//            configureView()
//        }
//    }
//
//    var sets : String? {
//        didSet{
//            configureView()
//        }
//    }
//
//    var ranking : Int? {
//        didSet{
//            configureView()
//
