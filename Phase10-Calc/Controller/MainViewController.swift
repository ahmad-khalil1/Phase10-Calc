//
//  ViewController.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/4/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
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
        
        players = makePlayerItemsArray()
        configureCollectionView()
        configureDataSource()
        configureView()
        
    }
    
    @objc func addButtonDidTaped( button : UIButton){
        let vc = AddPlayerVC()
        vc.delegate = self
        self.present( vc, animated: true )
    }
    
    func configureView(){
//        self.view.backgroundColor = .white
//        let headerImagView : UIImageView = {
//            let image = UIImageView(cornerRadius: 0)
//            image.image = #imageLiteral(resourceName: "header phase")
//            return image
//        }()
//        self.view.addSubview(headerImagView)
//        headerImagView.translatesAutoresizingMaskIntoConstraints = false
//        headerImagView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: -50 , left: 0, bottom: 0, right: 0))
//
//        let headerTextImage : UIImageView = {
//           let image = UIImageView(cornerRadius: 0)
//            image.translatesAutoresizingMaskIntoConstraints = false
//            image.image = #imageLiteral(resourceName: "Phase 10 text ")
//            return image
//        }()
//        self.view.addSubview(headerTextImage)
//        headerTextImage.anchor(top: nil, leading: headerImagView.leadingAnchor, bottom: headerImagView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 100, right: 0))
//
//        let addButton : UIButton = {
//            let button = UIButton()
//            button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
//
//            return button
//        }()
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(addButton)
//        addButton.anchor(top: nil , leading: nil, bottom: headerImagView.bottomAnchor , trailing: headerImagView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 15 , right: 40))
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
//        collectionView.fillSuperviewWithPadding(padding: .init(top: 100 , left: 0, bottom: 0, right: 0))
        collectionView.fillSuperView()
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
        group.contentInsets = .init(top: 15, leading: 20, bottom: 15 , trailing: 20)
//        group.contentInsets = .init(top: 15, leading: 0, bottom: 15 , trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
//        section.contentInsets = .init(top: 30, leading: 20, bottom: 10, trailing: 20)
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
                cell?.playerItem = item as? PlayerItem
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
        
        dataSource.supplementaryViewProvider = { collectionView , kind , indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
              return nil
            }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier, for: indexPath) as? SectionHeaderReusableView
            view?.addButton.addTarget(self, action: #selector(self.addButtonDidTaped), for: .touchUpInside)
            return view
        }
        let snapShot = snapShotForCurrentState()
        dataSource.apply(snapShot)
    }
    
    fileprivate func makePlayerItemsArray() -> [PlayerItem] {
        return [PlayerItem(name: "ahmad", rank: 1, phase: 5 , pionts: 20, sets: "on set of 4 ") , PlayerItem(name: "Shosha", rank: 2, phase: 2, pionts: 180, sets: "on set of ")  , PlayerItem(name: "Shosha", rank: 3, phase: 3, pionts: 20, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 4, phase: 2, pionts: 100, sets: "on set of ")  ]
    }
    
    func snapShotForCurrentState() -> NSDiffableDataSourceSnapshot<Section , Item> {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section , Item>()
//        snapShot.appendSections([Section.emoje])
//        snapShot.appendItems([EmojeItem(title: "😂") , EmojeItem(title: "😘") ,EmojeItem(title: "🥰") ,EmojeItem(title: "😇") ,EmojeItem(title: "😎") ,EmojeItem(title: "🥳")  ])
        
        
        snapShot.appendSections([Section.main])
        if let players = self.players {
            
            snapShot.appendItems(performSorting(array: players))
        }
        
        return snapShot
    }
    
    func performSorting(array : [PlayerItem]) -> [PlayerItem] {
        var sortedArray = array.sorted {
            if $0.phase == $1.phase {
                return  $0.pionts < $1.pionts
            }
            return  $0.phase > $1.phase
        }
        return sortedArray
    }

}
extension MainViewController : UICollectionViewDelegate {

}

extension MainViewController : addPlayerDelegate {
    func didEndChosingPlayerName(name: String, photo: UIImage) {
        players?.append(.init(name: name , rank: 0 , phase: 6 , pionts: 130 , sets: " 2 sets of 3 " , image: photo))
        //        var addSnapShot = NSDiffableDataSourceSnapshot<Section , Item>()
        //        var  snapshot = snapShotForCurrentState()
        //        snapshot.appendItems(players!)
        //        dataSource.apply(snapshot)
        let snapShot = snapShotForCurrentState()
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
}

//, PlayerItem(name: "Shosha", rank: 5, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 6, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 7, phase: 2, pionts: 180, sets: "on set of ") , PlayerItem(name: "Shosha", rank: 8, phase: 2, pionts: 180, sets: "on set of ")
