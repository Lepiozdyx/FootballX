//
//  PauseView.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

struct PauseView: View {
    let resumeAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            
            RectangleSubstrateView(text: "", width: 300, height: 220, color: .green2)
                .overlay(alignment: .top) {
                    RectangleSubstrateView(text: "PAUSE", width: 260, height: 50, color: .green2)
                        .offset(x: 0, y: -25)
                }
                .overlay {
                    VStack(spacing: 14) {
                        Button {
                            resumeAction()
                        } label: {
                            ActionView(text: "RESUME", width: 240, height: 60)
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
        }
    }
}

#Preview {
    PauseView(resumeAction: {}, menuAction: {})
}
