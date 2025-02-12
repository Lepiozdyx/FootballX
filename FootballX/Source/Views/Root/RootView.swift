//
//  RootView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var root = RootManager()
    
    var body: some View {
        Group {
            switch root.appState {
            case .loading:
                StartView()
            case .webView:
                if let url = root.webManager.myURL {
                    WebViewManager(url: url, webManager: root.webManager)
                } else {
                    WebViewManager(url: WebManager.targetURL, webManager: root.webManager)
                }
            case .mainMenu:
                MenuView()
            }
        }
        .onAppear {
            root.stateCheck()
        }
    }
}

#Preview {
    RootView()
}
