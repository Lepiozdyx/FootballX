//
//  MenuView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.scenePhase) private var scenePhase
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
                    CountView(number: 100)
                }
                .padding()
                
                // Menu buttons
                VStack {
                    Spacer()
                    Image(.ballX)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    
                    HStack {
                        NavigationLink {
                             PlayView()
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
                            // ShopView()
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
