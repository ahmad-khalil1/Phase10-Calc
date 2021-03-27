//
//  PlayerItem.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/4/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation
import UIKit

class PlayerItem : Item , NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let player = PlayerItem(name: name, rank: rank, phase: phase, pionts: pionts , image: image)
        return player
    }
    
//    private let identifier = UUID()
    
    var name : String
    var rank : Int?
    var phase : Int
    var pionts : Int
    var sets : String?
    var image : UIImage?
    
    init(name : String , rank : Int? = nil , phase : Int , pionts : Int , sets : String? = nil , image : UIImage? = nil){
        self.name = name
        self.rank = rank
        self.phase = phase
        self.pionts = pionts
        self.sets = sets
        self.image = image
    }
   
//    static func == (lhs: PlayerItem, rhs: PlayerItem) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
//
//    func hash(into hasher: inout Hasher) {
//      hasher.combine(identifier)
//    }
    
    
}
