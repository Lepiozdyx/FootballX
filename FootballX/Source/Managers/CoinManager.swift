//
//  CoinManager.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import Foundation

@MainActor
final class CoinManager: ObservableObject {
    static let shared = CoinManager()
    
    @Published private(set) var balance: Int {
        didSet {
            UserProgress.coins = balance
        }
    }
    
    init() {
        self.balance = UserProgress.coins
    }
    
    func add(_ amount: Int) {
        balance += amount
    }
    
    func spend(_ amount: Int) -> Bool {
        guard balance >= amount else { return false }
        balance -= amount
        return true
    }
}
