//
//  LevelCompleteView.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

struct LevelCompleteView: View {
    let level: Int
    let coins: Int
    let nextLevelAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            
            RectangleSubstrateView(text: "", width: 300, height: 300, color: .green2)
                .overlay(alignment: .top) {
                    RectangleSubstrateView(text: "YOU WIN!", width: 260, height: 50, color: .green2)
                        .offset(x: 0, y: -25)
                }
                .overlay {
                    VStack(spacing: 14) {
                        Text("Level \(level)")
                            .cFont(32)
                        
                        CountView(number: coins)
                        
                        VStack(spacing: 14) {
                            Button {
                                nextLevelAction()
                            } label: {
                                ActionView(text: "NEXT LEVEL", width: 240, height: 60)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                menuAction()
                            } label: {
                                ActionView(text: "MENU", width: 240, height: 60)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 20)
                }
        }
    }
}

#Preview {
    LevelCompleteView(
        level: 1,
        coins: 100,
        nextLevelAction: {},
        menuAction: {}
    )
}
