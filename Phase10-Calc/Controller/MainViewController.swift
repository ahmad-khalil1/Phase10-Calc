//
//  ViewController.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/4/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit
import SwipeCellKit

//Constans
enum phases : String , CaseIterable {
    case phase1 = "2 sets of 3"
    case phase2 = "1 set of 3 + 1 run of 4"
    case phase3 = "1 set of 4 + 1 run of 4"
    case phase4 = "1 run of 7"
    case phase5 = "1 run of 8"
    case phase6 = "1 run of 9"
    case phase7 = "2 sets of 4"
    case phase8 = "7 cards of 1 color"
    case phase9 = "1 set of 5 + 1 set of 2"
    case phase10 = "1 set of 5 + 1 set of 3"
}

class MainViewController: UIViewController {
//    let storyBoard = UIStoryboard(name: "storyboard", bundle: Bundle.main )
    
    enum Section : String, CaseIterable{
//        case emoje = "emoje"
        case main = "main"
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section , Item>
    var dataSource : DataSource! = nil
    var MainCollectionView : UICollectionView! = nil
    var players : [PlayerItem]?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        players = makePlayerItemsArray()
        configureCollectionView()
        configureDataSource()
        configureView()
        
    }
    
    @objc func addButtonDidTaped( button : UIButton){
        let vc = AddPlayerVC()
        vc.delegate = self
        self.present( vc, animated: true )
    }
    
    @objc func roundButtonDidTaped(button : UIButton) {
        if let players = players {
            if players.count >= 2 {
                let playersArray = performSorting(array: players)
                let vc = RoundFinishVC(stepsCount: players.count, playersArray: playersArray)
                vc.delegate = self
                self.present( vc, animated: true )
            }
        }
      
    }

    let roundButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Round Button"), for: .normal)
//        button.isEnabled = false
        return button
    }()
    
    func configureView(){
      
        self.view.addSubview(roundButton)
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        //        roundButton.creatShadow()
        roundButton.layer.shadowColor = UIColor.black.cgColor
        roundButton.layer.shadowOpacity = 0.4
        roundButton.layer.shadowOffset = .init(width: 0, height: 10)
        roundButton.layer.shadowRadius = 5
        roundButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 100, bottom: 20, right: 100))
//        roundButton.constrainWidth(constant: 172)
//        roundButton.constrainHeight(constant: 52)
        roundButton.addTarget(self, action: #selector(roundButtonDidTaped), for: .touchUpInside)
        
        self.view.backgroundColor = .white
        let headerImagView : UIImageView = {
            let image = UIImageView(cornerRadius: 0)
            image.image = #imageLiteral(resourceName: "header phase")
            return image
        }()
        self.view.addSubview(headerImagView)
        headerImagView.translatesAutoresizingMaskIntoConstraints = false
        headerImagView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: -50 , left: 0, bottom: 0, right: 0))

        let headerTextImage : UIImageView = {
           let image = UIImageView(cornerRadius: 0)
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "Phase 10 text ")
            return image
        }()
        self.view.addSubview(headerTextImage)
        headerTextImage.anchor(top: nil, leading: headerImagView.leadingAnchor, bottom: headerImagView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 100, right: 0))

        let addButton : UIButton = {
            let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
            return button
        }()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addButton)
        addButton.anchor(top: nil , leading: nil, bottom: headerImagView.bottomAnchor , trailing: headerImagView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 15 , right: 20))
        addButton.addTarget(self, action: #selector(self.addButtonDidTaped), for: .touchUpInside)
//-----------------------------------------------------
//        let backGroundImageView = UIImageView(cornerRadius: 0, image: #imageLiteral(resourceName: "gradient color"))
//        self.view.addSubview(backGroundImageView)
//        backGroundImageView.fillSuperView()
//        backGroundImageView.superview?.sendSubviewToBack(backGroundImageView)
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bacgroun2 "))
        
        
    }
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        MainCollectionView = collectionView
        collectionView.backgroundColor = .none
        collectionView.register(playerCVC.self, forCellWithReuseIdentifier: playerCVC.reuseIdentifier)
        collectionView.register(EmojeCVC.self, forCellWithReuseIdentifier: EmojeCVC.reuseIdentifier)
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
        collectionView.fillSuperviewWithPadding(padding: .init(top: 100 , left: 0, bottom: 0, right: 0))
//        collectionView.fillSuperView()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let sectionType = Section.allCases[sectionIndex]
            switch sectionType {
            case .main:
                return self.generateMainSectionLayout()
//            case .emoje:
//                return self.generatEmojeSectionLayout()
            }
        }
        return layout
    }
    
    func generateMainSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item])
//        group.contentInsets = .init(top: 15, leading: 20, bottom: 15 , trailing: 20)
        group.contentInsets = .init(top: 15, leading: 0, bottom: 15 , trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        sectionHeader.pinToVisibleBounds = true
//        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 30, leading: 20, bottom: 10, trailing: 20)
        
        return section
    }
    
    func generatEmojeSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(1/4)), subitem: item , count: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        return section
    }
    
    func configureDataSource(){
        dataSource = DataSource(collectionView: MainCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .main :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerCVC.reuseIdentifier, for: indexPath) as? playerCVC
                if let item = item as? PlayerItem {
//                    item.rank = indexPath.row + 1
                    cell?.playerItem = item
                }
                cell?.delegate = self
                return cell
//            case .emoje :
//                var emojeItem : EmojeItem?
//                if let item = item as? EmojeItem {
//                  emojeItem = item
//                }
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojeCVC.reuseIdentifier, for: indexPath) as? EmojeCVC
//                if let emojeItem = emojeItem {
//                    cell?.title = emojeItem.title
//
//                }
//                return cell
            }
           
        })
        
//        dataSource.supplementaryViewProvider = { collectionView , kind , indexPath in
//            guard kind == UICollectionView.elementKindSectionHeader else {
//              return nil
//            }
//            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier, for: indexPath) as? SectionHeaderReusableView
//            view?.addButton.addTarget(self, action: #selector(self.addButtonDidTaped), for: .touchUpInside)
//            return view
//        }
        let snapShot = snapShotForCurrentState()
        dataSource.apply(snapShot)
    }
    
    fileprivate func makePlayerItemsArray() -> [PlayerItem] {
        return [PlayerItem(name: "ahmad", rank: 1, phase: 5 , pionts: 20, sets: "on set of 4 ") , PlayerItem(name: "Shosha", rank: 2, phase: 2, pionts: 180, sets: "on set of ")  , PlayerItem(name: "zikry", rank: 3, phase: 3, pionts: 20, sets: "on set of ") , PlayerItem(name: "ali", rank: 4, phase: 2, pionts: 100, sets: "on set of ") , PlayerItem(name: "zikry", rank: 3, phase: 3, pionts: 20, sets: "on set of ") , PlayerItem(name: "ali", rank: 4, phase: 2, pionts: 100, sets: "on set of ")  ]
    }
    
    func snapShotForCurrentState() -> NSDiffableDataSourceSnapshot<Section , Item> {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section , Item>()
//        snapShot.appendSections([Section.emoje])
//        snapShot.appendItems([EmojeItem(title: "😂") , EmojeItem(title: "😘") ,EmojeItem(title: "🥰‘") ,EmojeItem(title: "😇") ,EmojeItem(title: "😎") ,EmojeItem(title: "🥳")  ])
        
        
        snapShot.appendSections([Section.main])
        if let players = self.players {
            
            var sortedArray = performSorting(array: players)
            for (index , player ) in sortedArray.enumerated() {
                player.rank = index + 1
                let phase = Int(sortedArray[index].phase)
                if (0...10).contains(phase) {
                    player.sets = phases.allCases[phase - 1].rawValue
                }
                
            }
            snapShot.appendItems(sortedArray)
        }
        return snapShot
    }
    
    func performSorting(array : [PlayerItem]) -> [PlayerItem] {
        var sortedArray = array.sorted {
            if $0.phase == $1.phase && $0.pionts == $1.pionts {
                return $0.name < $1.name
            }
            if $0.phase == $1.phase {
                return  $0.pionts < $1.pionts
            }
            return  $0.phase > $1.phase
        }
        return sortedArray
    }

    
    
}
extension MainViewController : UICollectionViewDelegate  , SwipeCollectionViewCellDelegate {
    

    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive
        , title: nil) { action, indexPath in
            // handle action by updating model with deletion
            
//            action.transitionDelegate = ScaleTransition.default
            if  let item = self.dataSource.itemIdentifier(for: indexPath) as? PlayerItem {
                guard let index = self.players?.firstIndex(of: item) else { return }
                self.players?.remove(at: index)
                var snapShot = self.snapShotForCurrentState()
                //            snapShot.deleteItems([item])
//                action.fulfill(with: .delete)
                snapShot.reloadSections([.main])
                
                self.dataSource.apply(snapShot, animatingDifferences: true)
            }
            
        }
        
        deleteAction.backgroundColor =  .none
//            #colorLiteral(red: 0.831372549, green: 0.7098039216, blue: 0.6901960784, alpha: 1).withAlphaComponent(0.0)
        
//            #colorLiteral(red: 0.04087775201, green: 0.120924212, blue: 0.2315217853, alpha: 1)
//        deleteAction.highlightedBackgroundColor = .black
        
        // customize the action appearance
//        deleteAction.
        deleteAction.image = #imageLiteral(resourceName: "delete-icon")
        

        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .fill
        options.backgroundColor = .clear
//        options.expansionDelegate = ScaleAndAlphaExpansion.default
//        options.expansionDelegate = self
//            #colorLiteral(red: 1, green: 0.2299106419, blue: 0.1861539483, alpha: 1)
        options.transitionStyle = .reveal
        return options
    }
    
    func collectionView(_ collectionView: UICollectionView, willBeginEditingItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {
        let cell =  MainCollectionView.cellForItem(at: indexPath) as? playerCVC
        cell?.isDragging = true
//        var snapshot = snapShotForCurrentState()
//        let item = dataSource.itemIdentifier(for: indexPath)
//        cell?.contentView.backgroundColor = .yellow
        //        dataSource.apply(snapshot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndEditingItemAt indexPath: IndexPath?, for orientation: SwipeActionsOrientation) {
        if let indexPath = indexPath {
            let cell =  MainCollectionView.cellForItem(at: indexPath) as? playerCVC
            cell?.isDragging = false
            //            var snapshot = snapShotForCurrentState()
            //            let item = dataSource.itemIdentifier(for: indexPath)
            //            snapshot.reloadItems([item!])
            //            dataSource.apply(snapshot)
        }
        print("cell")
        
    }
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) as? PlayerItem {
//            var cell = MainCollectionView.cellForItem(at: indexPath) as? playerCVC
//            cell?.phaseLabel.backgroundColor = .black
//            print(cell)
            let vc = EditingPopUpVC(playerItem: item, playerIndex: indexPath)
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
        
//        if (0...9).contains(item.phase){
//                     item.phase += 1
//                 }
//                 var snapShot = snapShotForCurrentState()
//                 players.map{
//                     snapShot.reloadItems($0)
//                 }
//                 dataSource.apply(snapShot, animatingDifferences: true)

    
    //--------------------------------------------------------------------------
//        if let item = players?[indexPath.row] {
//            item.phase += 1
//        }
//        let snapShot = snapShotForCurrentState()
//        dataSource.apply(snapShot, animatingDifferences: true)
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let playersCount = players?.count {
//            if playersCount > 6 {
//                var snapShot = snapShotForCurrentState()
//                snapShot.reloadItems([ players![playersCount-1], players![playersCount-2] ])
//                dataSource.apply(snapShot, animatingDifferences: true)
//            }
//        }
//    }
}

extension MainViewController : addPlayerDelegate {
    func didEndChosingPlayerName(name: String, photo: UIImage) {
        var item : PlayerItem
        if var players = players {
            item = .init(name: name , rank: 0 , phase: 1 , pionts: 0  , image: photo)
            self.players?.append(item)
            roundButton.isEnabled = true
        }else {
            item = .init(name: name , rank: 0 , phase: 1 , pionts: 0  , image: photo)
            players = [item]
        }
                var addSnapShot = NSDiffableDataSourceSnapshot<Section , Item>()
                var  snapshot = snapShotForCurrentState()
                snapshot.appendItems(players!)
                dataSource.apply(snapshot)
        
       
//        players.map{
//            snapShot.reloadItems($0)
//        }
    }
}

extension MainViewController : RoundFinishedDataDelegate {
    func didEnterdPiontsAndPhase(playersArray: [PlayerItem]) {
        players = playersArray
        var snapShot = snapShotForCurrentState()
        players.map{
            snapShot.reloadItems($0)
        }
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
  
//    func didEnterdPiontsAndPhase(pionts: Int, phaseDone: Bool) {
//        //        if let item = dataSource.itemIdentifier(for: indexPath) as? PlayerItem {
//        if let players = players {
//            if phaseDone {
//                players.map{ $0.phase += 1  }
//            }
//            players.map{ $0.pionts += pionts}
//        }
//        //            if (0...9).contains(item.phase){
//        //                item.phase += 1
//        //            }
//        var snapShot = snapShotForCurrentState()
//        players.map{
//            snapShot.reloadItems($0)
//        }
//        dataSource.apply(snapShot, animatingDifferences: true)
//        //    }
//
//    }
    //-------
}

extension MainViewController : editingPopUpViewDelegate {
    func didFinishEditingPlayer(pionts: Int, phase: Int, playerIndexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: playerIndexPath) as? PlayerItem {
            if pionts == 0 && phase == 0 {
                return
            }
            if pionts != 0  {
                item.pionts = pionts
            }
            if phase != 0 {
                item.phase = phase
            }
            var snapShot = snapShotForCurrentState()
            players.map{
                snapShot.reloadItems($0)
            }
            dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}
  
//, PlayerItem(name: "Shosha", rank: 5, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 6, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 7, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 8, phase: 2, pionts: 180, sets: "on set of ")


//print(player.name, "Rank" , player.rank , "index" ,index)
//print(player.name, "Rank" , player.rank , "index" ,index , "\n")
//if index == sortedArray.count - 1 {
//    print("--------------------------------------------------------------------------")
//}

class vc : UIViewController {
    
}
