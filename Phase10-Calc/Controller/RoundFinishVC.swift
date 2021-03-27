//
//  RoundFinishVC.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/15/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar

protocol RoundFinishedDataDelegate {
    func didEnterdPiontsAndPhase(playersArray : [PlayerItem])
}

enum Direction {
    case next
    case back
}
class RoundFinishVC: ModallyPresentedVC {
    
    let stepsCount : Int
    let playersArrayReffrence : [PlayerItem]
    var refrenceArray = [[0]]
    var arryPlayers : [PlayerItem] = []
    
    init(stepsCount : Int , playersArray : [PlayerItem] ){
        self.stepsCount = stepsCount
        self.playersArrayReffrence = playersArray
        nameLabel.text = playersArray[0].name
        self.arryPlayers = playersArray.map{$0.copy() as! PlayerItem}
//        playersArray.map{
//            refrenceArray.insert(<#T##newElement: [Int]##[Int]#>, at: <#T##Int#>) $0.pionts
//        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var piontsCount = 0
    var delegate : RoundFinishedDataDelegate!
    
    fileprivate var indexPath : Int = 0
    
    var progresView : FlexibleSteppedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        configureView()
        
        
    }
    
    
    
    let checkButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Checkmark on Black Copy 2"),for: .normal)
        button.setImage(#imageLiteral(resourceName: "Checkmark on Black"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonDidTaped), for: .touchUpInside)
        return button
    }()

    
    var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "noun_Left right pagination button_1814219 Copy 2"), for: .normal)
        button.addTarget(self, action: #selector(nextButtonDidTaped), for: .touchUpInside)
        return button
    }()
    
    
   
    let backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "noun_Left right pagination button_1814219 Copy"), for: .normal)
        button.addTarget(self, action: #selector(backButtonDidTaped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let nameLabel = UILabel(text: "Ahmad" , font: UIFont(name: "Futura-Bold", size: 30) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor:#colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1))
    
    let phaseDoneLabel = UILabel(text: "    Phase Done ", font: UIFont(name: "Futura-Bold", size: 35) ?? UIFont.systemFont(ofSize: 1), numberOfLines: 1 , fontcolor:#colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1))
    
    @objc func checkButtonDidTaped(_ sender : UIButton) {
        sender.isSelected  = sender.isSelected ? false : true
    }
    
    let numPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.setValue(#colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1), forKey: "textColor")

        return picker
    }()
    
    func configureView() {
        configureProgressView()
        numPickerView.dataSource = self
        numPickerView.delegate = self
//        view.addSubview(numPickerView)
//        numPickerView.centerInSuperview()
        
        
        //        self.view.addSubview(checkButton)
        //        checkButton.centerInSuperview()
        
        let horizantelCheckStackView = UIStackView(arrangedSubviews: [ phaseDoneLabel , checkButton , UIView() ])
        horizantelCheckStackView.axis = .horizontal
        horizantelCheckStackView.alignment = .center
        horizantelCheckStackView.spacing = 20
        horizantelCheckStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let nextAndBackHorizantelStackView = UIStackView(arrangedSubviews: [ backButton  , UIView(), nextButton  ])
        nextAndBackHorizantelStackView.axis = .horizontal
        nextAndBackHorizantelStackView.alignment = .center
        nextAndBackHorizantelStackView.spacing = 20
        nextAndBackHorizantelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let pview = UIView()
        let verticalStack = VerticalStackView(arrangedSubViewsArray: [ nameLabel , horizantelCheckStackView , numPickerView   , nextAndBackHorizantelStackView], spacing: 30)
        verticalStack.setCustomSpacing(200, after: numPickerView )
        verticalStack.alignment = .center
        
        
        view.addSubview(verticalStack)
        verticalStack.centerInSuperview()
        
        //        view.addSubview(horizantelCheckStackView)
        //        horizantelCheckStackView.centerInSuperview()
//        horizantelCheckStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: 5, left: 10, bottom: 0, right: 10 ))
     
    }
    override func doneButtonDidTaped(button: UIButton) {
        if indexPath == stepsCount - 1 {
            self.dismiss(animated: true)
            updateData(index: indexPath , direction: .next)
            
            delegate.didEnterdPiontsAndPhase(playersArray: arryPlayers )
            
        }
    }
}

extension RoundFinishVC : UIPickerViewDataSource , UIPickerViewDelegate {
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        piontsCount = (pickerView.selectedRow(inComponent: 0) * 100) + (pickerView.selectedRow(inComponent: 1)*10) + pickerView.selectedRow(inComponent: 2)
//        progresView.step
//        guard progresView.currentIndex != stepsCount - 1 else { return }
//        progresView.currentIndex += 1
//        print(indexPath)

    }
    
}

extension RoundFinishVC : FlexibleSteppedProgressBarDelegate {
    func configureProgressView() {
        progresView = FlexibleSteppedProgressBar()
        progresView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progresView)
        
        progresView.anchor(top: view.topAnchor ,leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: UIEdgeInsets(top: 60 , left: 10, bottom: 0, right: 10))
        progresView.constrainWidth(constant: view.frame.width - 20 )
        progresView.constrainHeight(constant: 10)
        
        progresView.numberOfPoints = stepsCount
        progresView.lineHeight = 6
        progresView.radius = 20
        progresView.progressRadius = 10
        progresView.progressLineHeight = 6
        progresView.displayStepText = false
//        progresView.tintColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1)
//        progresView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1)
        progresView.selectedBackgoundColor = #colorLiteral(red: 0.06274509804, green: 0.2156862745, blue: 0.3607843137, alpha: 1)
//            #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        progresView.backgroundShapeColor = #colorLiteral(red: 0.9529411765, green: 0.7764705882, blue: 0.137254902, alpha: 1)
//            #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1)
        progresView.viewBackgroundColor = #colorLiteral(red: 0.2941176471, green: 0.3647058824, blue: 0.4039215686, alpha: 1)
        progresView.currentSelectedCenterColor = #colorLiteral(red: 0.06274509804, green: 0.2156862745, blue: 0.3607843137, alpha: 1)
        progresView.selectedOuterCircleStrokeColor = .white
        progresView.delegate = self
        progresView.stepAnimationDuration = 0.5
//        progresView.currentIndex +=
    }
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        switch position {
        case .bottom:
            return ""
        case .center:
            return ""
        case .top:
            return ""
        }
    }
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, canSelectItemAtIndex index: Int) -> Bool {
        return false
    }
}

extension RoundFinishVC {
    
    @objc func backButtonDidTaped(_ button : UIButton){
        guard progresView.currentIndex != 0 else { return }
        doneButton.isEnabled = false
        progresView.currentIndex -= 1
        
        
        backButton.isEnabled = progresView.currentIndex != 0
        nextButton.isEnabled = progresView.currentIndex != stepsCount - 1
        
        guard indexPath != 0 else {return}
        indexPath -= 1
        
        updatePagesUI(index: indexPath , direction:  .back)
        updateData(index: indexPath , direction: .back)
        
    }
    
    @objc func nextButtonDidTaped(_ button : UIButton){
        guard progresView.currentIndex != stepsCount - 1 else { return }
        progresView.currentIndex += 1
        
        backButton.isEnabled = progresView.currentIndex != 0
        nextButton.isEnabled = progresView.currentIndex != stepsCount - 1
        
        
        updateData(index : indexPath , direction: .next)

        guard indexPath != stepsCount - 1 else {return }
        indexPath += 1
        updatePagesUI(index: indexPath , direction: .next)

        piontsCount = 0
        
        if indexPath ==  stepsCount - 1 {
            doneButton.isEnabled = true
        }
    }
    
    fileprivate func updatePagesUI(index : Int , direction : Direction){
        switch direction {
        case .next :
            self.nameLabel.text = playersArrayReffrence[index].name
            self.numPickerView.selectRow(0, inComponent: 0, animated: true)
            self.numPickerView.selectRow(0, inComponent: 1, animated: true)
            self.numPickerView.selectRow(0, inComponent: 2, animated: true)
            self.checkButton.isSelected = false
        case .back :
            self.nameLabel.text = playersArrayReffrence[index].name
            let selectedPionts =  arryPlayers[index].pionts - playersArrayReffrence[index].pionts
            let donePhase =  arryPlayers[index].phase - playersArrayReffrence[index].phase
            let digitsArray = getDigits(selectedPionts)
            print(digitsArray)
            self.checkButton.isSelected = donePhase != 1 
            self.numPickerView.selectRow(digitsArray[0], inComponent: 0, animated: true)
            self.numPickerView.selectRow(digitsArray[1], inComponent: 1, animated: true)
            self.numPickerView.selectRow(digitsArray[2], inComponent: 2, animated: true)
            piontsCount = selectedPionts
            print ("update UI .back")
            print(selectedPionts , "selected Pionts current ,  curret index \(index) \n" ,  donePhase , "phase current , curret index \(index)")
        }
       
//        print(index)
        
    }
    
    fileprivate func updateData(index : Int , direction : Direction) {
//        print(index)
        switch direction {
        case .next :
            arryPlayers[index].pionts += piontsCount
            if !checkButton.isSelected {
                arryPlayers[index].phase += 1
            }
//            print(getDigits(piontsCount))
            print( arryPlayers[index].pionts , "pionts in current array index \(index)" , playersArrayReffrence[index].pionts , "pionts in refrence array index \(index) \n " , arryPlayers[index].phase , "phase in current array index \(index)" ,  playersArrayReffrence[index].phase , "phase in refrence array index \(index) \n ")
        case .back :
            arryPlayers[index].pionts = playersArrayReffrence[index].pionts
            arryPlayers[index].phase = playersArrayReffrence[index].phase
            
//            print ("updateData  .back")
//            print( arryPlayers[index].pionts , "pionts in current array index \(index)" , playersArrayReffrence[index].pionts , "pionts in refrence array index \(index) \n " , arryPlayers[index].phase , "phase in current array index \(index)" ,  playersArrayReffrence[index].phase , "phase in refrence array index \(index) \n ")
            
        }
        
    }
    
    fileprivate func getDigits(_ numR : Int) -> [Int] {
        let count = String(numR).count
        var digits = [Int]()
        var num = numR
        for _  in 0...count - 1  {
            digits.append(num % 10)
            num = num / 10
        }
        if count == 2 {
            digits.append(0)
           
        }else if count == 1 {
            digits.append(0)
            digits.append(0)
        }
        return digits.reversed()
    }
}

//for family in UIFont.familyNames.sorted() {
//              let names = UIFont.fontNames(forFamilyName: family)
//              print("Family: \(family) Font names: \(names)")
//}
