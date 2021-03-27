//
//  AddPlayerVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/10/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit

protocol addPlayerDelegate {
    func didEndChosingPlayerName(name : String , photo : UIImage)
}

class AddPlayerVC: ModallyPresentedVC {

    var delegate : addPlayerDelegate!
    
    var nameLabel = UILabel(text: "Name:", font: .boldSystemFont(ofSize: 25), numberOfLines: 1, fontcolor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    
    let playerAvatarPhoto = UIImageView(cornerRadius: 0, image: UIImage(named: "big-man-\(Int.random(in: 0...4))"))
    
//    let cancelButton : UIButton = {
//        let button = UIButton(type: .roundedRect)
//        button.setTitle("Cancel", for: .normal)
////        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        button.tintColor =  #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
//        return button
//    }()
//
//
//    let doneButton : UIButton = {
//        let button =  UIButton(title: "Done")
////        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
//        button.tintColor =   #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        button.isEnabled = false
//        return button
//    }()
    
    var textField : UITextField = {
        let field = UITextField()
        field.backgroundColor =  #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        field.tintColor = #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        field.textColor = #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        field.font = .boldSystemFont(ofSize: 20)
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.clearButtonMode = UITextField.ViewMode.always
        field.autocapitalizationType = UITextAutocapitalizationType.sentences
        field.placeholder = " Name...                                      "
        field.returnKeyType = .done
//        field.ret
        return field
    }()
    
    
    fileprivate func addViewstoTheMainView(_ vertiaclStack: VerticalStackView) {
        view.addSubview(vertiaclStack)
//        view.addSubview(buttonsHorizantalStackView)
        //        view.addSubview(cancelButton)
        //        view.addSubview(doneButton)
    }
    
    fileprivate func setupConstrains(_ vertiaclStack: VerticalStackView) {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        playerAvatarPhoto.translatesAutoresizingMaskIntoConstraints = false
        vertiaclStack.translatesAutoresizingMaskIntoConstraints = false
//        buttonsHorizantalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        playerAvatarPhoto.constrainWidth(constant: 183)
        playerAvatarPhoto.constrainHeight(constant: 183)
        
//        buttonsHorizantalStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: 5, left: 10, bottom: 0, right: 10 ))
        vertiaclStack.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 0, bottom: 100, right: 0)  )
    }
    
    fileprivate func configureView() {
        let vertiaclStack = VerticalStackView(arrangedSubViewsArray: [playerAvatarPhoto , textField , UIView()], spacing: 40)
        vertiaclStack.alignment = .center
        
//        let buttonsHorizantalStackView = UIStackView(arrangedSubviews: [cancelButton , UIView() , doneButton ])
//        buttonsHorizantalStackView.axis = .horizontal
//        buttonsHorizantalStackView.alignment = .center
//        buttonsHorizantalStackView.spacing = 20
        
        playerAvatarPhoto.contentMode = .scaleAspectFit
        
        view.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        
        addViewstoTheMainView(vertiaclStack)
        setupConstrains(vertiaclStack)
    }
    
//    @objc func cancelButtonDidTaped(button : UIButton ){
//        self.dismiss(animated: true)
//    }
    @objc override func doneButtonDidTaped(button : UIButton ){
        if let name = textField.text , let image = playerAvatarPhoto.image {
            delegate.didEndChosingPlayerName( name: name , photo: image)
        }
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        textField.delegate = self
        
//        cancelButton.addTarget(self, action: #selector(cancelButtonDidTaped), for: .touchUpInside)
//        doneButton.addTarget(self, action: #selector(doneButtonDidTaped), for: .touchUpInside)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension AddPlayerVC : UITextFieldDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        doneButton.isEnabled = true
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        doneButton.isEnabled = true
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneButton.isEnabled = false
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ==  0 {
            return false
        }
        if let name = textField.text , let image = playerAvatarPhoto.image {
            delegate.didEndChosingPlayerName(name:name  , photo: image  )
        }
        dismiss(animated: true )
        return true
    }
}


//let horizontalStack = UIStackView(arrangedSubviews: [ textField ])
//     horizontalStack.spacing = 20
//     horizontalStack.axis = .horizontal
//     horizontalStack.alignment = .center
//         horizontalStack.translatesAutoresizingMaskIntoConstraints = false

//        , size: .init(width: view.bounds.inset(by: view.safeAreaInsets).width , height: 45) size: .init(width: view.bounds.inset(by: view.safeAreaInsets).width , height: 400)
