//
//  GameOverView.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

struct GameOverView: View {
//    let level: Int
    let retryAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            
            RectangleSubstrateView(text: "", width: 300, height: 240, color: .green2)
                .overlay(alignment: .top) {
                    RectangleSubstrateView(text: "YOU LOSE", width: 260, height: 50, color: .green2)
                        .offset(x: 0, y: -25)
                }
                .overlay {
                    VStack(spacing: 20) {
//                        Text("Level \(level)")
//                            .cFont(32)
                        
                        VStack(spacing: 14) {
                            Button {
                                retryAction()
                            } label: {
                                ActionView(text: "TRY AGAIN", width: 240, height: 60)
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
    GameOverView(
//        level: 3,
        retryAction: {},
        menuAction: {}
    )
}
