//
//  RootViewModel.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import Foundation

@MainActor
final class RootManager: ObservableObject {
    enum AppState {
        case loading
        case webView
        case mainMenu
    }
    
    @Published private(set) var appState: AppState = .loading
    
    let webManager: WebManager
    
    init(webManager: WebManager = WebManager()) {
        self.webManager = webManager
    }
    
    func stateCheck() {
        Task {
            if webManager.myURL != nil {
                appState = .webView
                return
            }
            
            do {
                if try await webManager.checkInitialURL() {
                    appState = .webView
                } else {
                    appState = .mainMenu
                }
            } catch {
                appState = .mainMenu
            }
        }
    }
}
