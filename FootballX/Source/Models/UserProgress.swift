//
//  UserProgress.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import Foundation

struct UserProgress {
    static let defaults = UserDefaults.standard
    
    static var currentLevel: Int {
        get { defaults.integer(forKey: "currentLevel") }
        set { defaults.set(newValue, forKey: "currentLevel") }
    }
    
    static var coins: Int {
        get { defaults.integer(forKey: "coins") }
        set { defaults.set(newValue, forKey: "coins") }
    }
    
    static func resetProgress() {
        currentLevel = 1
        coins = 0
    }
}
