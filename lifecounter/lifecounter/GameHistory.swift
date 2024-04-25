//
//  GameHistory.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/25/24.
//

import Foundation


class GameHistory {
    static var shared = GameHistory()
    
    private init() {}
    
    var entries: [String] = []
    
    func addEntry(_ entry: String) {
        entries.append(entry)
    }
    
    func clearHistory(){
        entries.removeAll()
    }
}
