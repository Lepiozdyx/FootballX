//
//  ShopManager.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import Foundation

@MainActor
final class ShopManager: ObservableObject {
    static let shared = ShopManager()
    
    let skins: [FieldSkin] = [
        FieldSkin(id: 0, image: .field, price: 0, title: "CLASSIC"),
        FieldSkin(id: 1, image: .field2, price: 10, title: "SEMI-PRO"),
        FieldSkin(id: 2, image: .field3, price: 50, title: "PRO")
    ]
    
    @Published private(set) var purchasedSkinIds: Set<Int> {
        didSet {
            UserDefaults.standard.set(Array(purchasedSkinIds), forKey: "purchasedSkins")
        }
    }
    
    @Published private(set) var selectedSkinId: Int {
        didSet {
            UserDefaults.standard.set(selectedSkinId, forKey: "selectedSkinId")
        }
    }
    
    private init() {
        let purchased = Set(UserDefaults.standard.array(forKey: "purchasedSkins") as? [Int] ?? [0])
        purchasedSkinIds = purchased.isEmpty ? [0] : purchased
        
        let selected = UserDefaults.standard.integer(forKey: "selectedSkinId")
        if purchased.contains(selected) {
            selectedSkinId = selected
        } else {
            selectedSkinId = 0
        }
    }
    
    var currentSkin: FieldSkin {
        skins.first { $0.id == selectedSkinId } ?? skins[0]
    }
    
    func isSkinPurchased(_ skin: FieldSkin) -> Bool {
        purchasedSkinIds.contains(skin.id)
    }
    
    func purchaseSkin(_ skin: FieldSkin) {
        guard !isSkinPurchased(skin) else { return }
        purchasedSkinIds.insert(skin.id)
        selectedSkinId = skin.id
    }
    
    func selectSkin(_ skin: FieldSkin) {
        guard isSkinPurchased(skin) else { return }
        selectedSkinId = skin.id
    }
}
