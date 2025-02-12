//
//  SettingsState.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import Foundation

@MainActor
final class SettingsState: ObservableObject {
    static let shared = SettingsState()
    
    @Published var isMusicEnabled: Bool {
        didSet {
            settings.isMusicEnabled = isMusicEnabled
        }
    }
    
    private let settings = SettingsManager.shared
    
    private init() {
        self.isMusicEnabled = settings.isMusicEnabled
    }
}
