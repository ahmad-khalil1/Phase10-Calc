//
//  editingPopUpVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/19/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit
import GMStepper


protocol editingPopUpViewDelegate {
    func didFinishEditingPlayer(pionts : Int , phase : Int , playerIndexPath : IndexPath)
}

class EditingPopUpVC: UIViewController {
    
    private let popUpWindowView = PopUpWindowView()
    var finalPionts = 0
    var finalPhase = 0
    var indexPath : IndexPath
    var delegate : editingPopUpViewDelegate!
    
    init ( playerItem : PlayerItem , playerIndex : IndexPath  ) {
        self.indexPath = playerIndex
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.piontsStepper.value =  Double(playerItem.pionts)
        popUpWindowView.phaseStepper.value = Double(playerItem.phase)
        popUpWindowView.nameLabel.text = playerItem.name.capitalized
        popUpWindowView.doneButton.addTarget(self, action: #selector(doneButtonDidTaped), for: .touchUpInside)
        popUpWindowView.piontsStepper.addTarget(self, action: #selector(stepperValueDidChanged), for: .valueChanged)
        popUpWindowView.phaseStepper.addTarget(self, action: #selector(stepperValueDidChanged), for: .valueChanged)


        self.view = popUpWindowView
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    @objc func doneButtonDidTaped(){
        delegate.didFinishEditingPlayer(pionts: finalPionts, phase: finalPhase, playerIndexPath: indexPath)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func stepperValueDidChanged( stepper : GMStepper ) {
        if stepper == popUpWindowView.phaseStepper {
            finalPhase = Int(stepper.value)
            
        }else if stepper == popUpWindowView.piontsStepper {
            finalPionts = Int(stepper.value)
            
        }
    }
}

private class PopUpWindowView: UIView {
    
    let nameLabel = UILabel(text: "Ahmad" , font: UIFont(name: "Futura-Bold", size: 30) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor:#colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1))
    
    let popUpView : UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUPConstrains() {
        
    }
    
    let piontsStepper : GMStepper = {
       let stepper = GMStepper()
        stepper.value = 0
        stepper.maximumValue = 250
        stepper.minimumValue = 0
        stepper.showIntegerIfDoubleIsInteger = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    let phaseStepper : GMStepper = {
        let stepper = GMStepper(frame: .zero)
        stepper.value = 0
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.showIntegerIfDoubleIsInteger = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
//    let phaseStepper = GMStepper()
    let doneButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.2509803922, blue: 0.3176470588, alpha: 1)
        
        return button
    }()
    
    func configureView() {
        
        let verticalStack = VerticalStackView(arrangedSubViewsArray: [nameLabel , phaseStepper , piontsStepper  , UIView()] , spacing:  10 )
        verticalStack.alignment = .center
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
       
//        piontsStepper.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: 20 ).isActive = true
//        piontsStepper.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: 20).isActive = true
//
//        phaseStepper.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: 20 ).isActive = true
//        phaseStepper.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: 20).isActive = true
//
        phaseStepper.constrainHeight(constant: 70)
        phaseStepper.constrainWidth(constant: 210)
        
        nameLabel.constrainHeight(constant: 50)
        
        piontsStepper.constrainHeight(constant: 70)
        piontsStepper.constrainWidth(constant: 210)
//
        doneButton.constrainHeight(constant: 60)
        
        popUpView.addSubview(verticalStack)
        popUpView.addSubview(doneButton)
        
        
        verticalStack.anchor(top:popUpView.topAnchor , leading: popUpView.leadingAnchor, bottom: doneButton.topAnchor, trailing: popUpView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 10, right: 20))
        
        doneButton.anchor(top:nil, leading:  popUpView.leadingAnchor, bottom:  popUpView.bottomAnchor, trailing:  popUpView.trailingAnchor, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
//        fillSuperviewWithPadding(padding: .init(top: 20, left: 20, bottom: 20, right: 20  ))
        

        
        addSubview(popUpView)
        popUpView.constrainWidth(constant: 300 )
        popUpView.constrainHeight(constant: 310 )
        popUpView.centerInSuperview()
        
    }
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

