//
//  SettingsView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var settingsState = SettingsState.shared
    private var settingsManager = SettingsManager.shared
    
    var body: some View {
        ZStack {
            BgView()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        TopBarButton(name: "xmark")
                    }
                    Spacer()
                }
                
                Spacer()
                RectangleSubstrateView(text: "", width: 350, height: 350, color: .green2)
                    .overlay(alignment: .top) {
                        RectangleSubstrateView(text: "SETTINGS", width: 260, height: 50, color: .green2)
                            .offset(x: 0, y: -25)
                    }
                    .overlay {
                        VStack(spacing: 40) {
                            VStack {
                                Text("MUSIC")
                                    .cFont(24)
                                CustomToggleView(isEnabled: settingsState.isMusicEnabled) {
                                    settingsState.isMusicEnabled.toggle()
                                }
                            }
                            
                            
                            Button {
                                settingsManager.rateApp()
                            } label: {
                                ActionView(text: "RATE US", width: 180, height: 50)
                            }
                        }
                        .padding()
                    }
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView()
}
