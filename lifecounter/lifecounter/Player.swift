//
//  Player.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/24/24.
//

import Foundation

class Player {
    var name: String
    var lifeTotal: Int
    
    init(name: String, lifeTotal: Int = 20) {
        self.name = name
        self.lifeTotal = lifeTotal
    }
}
