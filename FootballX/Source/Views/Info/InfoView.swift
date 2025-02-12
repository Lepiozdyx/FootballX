//
//  InfoView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            BgView()
            
            // Top bar elements
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        TopBarButton(name: "arrowshape.backward.fill")
                    }
                    Spacer()
                }
                
                Spacer()
                RectangleSubstrateView(text: "", width: 350, height: 350, color: .green2)
                    .overlay(alignment: .top) {
                        RectangleSubstrateView(text: "INFO", width: 260, height: 50, color: .green2)
                            .offset(x: 0, y: -25)
                    }
                    .overlay {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Text("Your goal is to intercept the ball and prevent it from leaving the field. The ball starts from the center, and you can place obstacles (by clicking on free squares) to block its path. Each turn the ball can move one adjacent square in any direction. Plan your moves strategically to surround him and prevent him from reaching the edge of the field!")
                                    .cFont(14)
                                
                                HStack {
                                    Image(.example1)
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(.example2)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                        .padding(.top, 30)
                        .padding(.horizontal)
                    }
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InfoView()
}
