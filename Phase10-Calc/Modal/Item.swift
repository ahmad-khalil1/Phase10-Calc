//
//  Item.swift
//  Phase10-Calc
//
//  Created by Ahmad Khalil on 8/5/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

class Item : Hashable {
    
    private let identifier = UUID()
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
