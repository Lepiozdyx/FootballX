//
//  MenuView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var coinManager = CoinManager.shared
    @State private var isSettings = false
    private let settings = SettingsManager.shared
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                BgView()
                
                // Top bar elements
                HStack {
                    Button {
                        isSettings.toggle()
                    } label: {
                        TopBarButton(name: "gearshape.fill")
                    }
                    Spacer()
                    // TODO: add number of coins
                    CountView(number: coinManager.balance)
                }
                .padding()
                
                // Menu buttons
                VStack {
                    Spacer()
                    Image(.ballX)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    
                    HStack {
                        NavigationLink {
                            PlayView(coinManager: coinManager)
                        } label: {
                            Image(.playCard)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                .overlay(alignment: .bottom) {
                                    Text("PLAY")
                                        .cFont(24)
                                }
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            ShopView(coinManager: coinManager)
                        } label: {
                            Image(.shopCard)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                .overlay(alignment: .bottom) {
                                    Text("SHOP")
                                        .cFont(24)
                                }
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                             InfoView()
                        } label: {
                            Image(.infoCard)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                .overlay(alignment: .bottom) {
                                    Text("INFO")
                                        .cFont(24)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .sheet(isPresented: $isSettings) {
                SettingsView()
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            settings.playBackgroundMusic()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                settings.playBackgroundMusic()
            case .background, .inactive:
                settings.stopBackgroundMusic()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    MenuView()
}
