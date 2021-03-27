//
//  ModallyPresentedVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/15/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit

class ModallyPresentedVC: UIViewController {
    
    var buttonsHorizantalStackView : UIStackView!
        let cancelButton : UIButton = {
            let button = UIButton(type: .roundedRect)
            button.setTitle("Cancel", for: .normal)
    //        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            button.tintColor =  #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            return button
        }()
        
        
        let doneButton : UIButton = {
            let button =  UIButton(title: "Done")
    //        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            button.tintColor =   #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            
            button.isEnabled = false
            return button
        }()
    
    @objc func cancelButtonDidTaped(button : UIButton ){
        self.dismiss(animated: true)
    }
    @objc func doneButtonDidTaped(button : UIButton ){
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsHorizantalStackView = UIStackView(arrangedSubviews: [cancelButton , UIView() , doneButton ])
        buttonsHorizantalStackView.axis = .horizontal
        buttonsHorizantalStackView.alignment = .center
        buttonsHorizantalStackView.spacing = 20
        
        view.addSubview(buttonsHorizantalStackView)
        
        buttonsHorizantalStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsHorizantalStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: 5, left: 10, bottom: 0, right: 10 ))
        
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTaped), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonDidTaped), for: .touchUpInside)
//        
        
    }
        

}
