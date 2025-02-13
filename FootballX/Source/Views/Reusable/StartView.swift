//
//  StartView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct StartView: View {
    @State private var progress: CGFloat = 0
    @State private var ballOffset: CGFloat = 0
    @State private var isBouncing = false
    
    var body: some View {
        ZStack {
            BgView()
            
            VStack(spacing: 30) {
                Image(.ball)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .offset(y: ballOffset)
                    .onAppear {
                        startBouncing()
                    }
                
                VStack {
                    Text("LOADING...")
                        .cFont(32)
                    
                    ActionView(text: "", width: 250, height: 30)
                        .overlay(alignment: .leading) {
                            Capsule()
                                .foregroundStyle(.yellow1)
                                .frame(width: progress * 250, height: 30)
                        }
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 0.9)) {
                progress = 1
            }
        }
    }
    
    private func startBouncing() {
        withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
            ballOffset = -60
        }
    }
}

#Preview {
    StartView()
}
