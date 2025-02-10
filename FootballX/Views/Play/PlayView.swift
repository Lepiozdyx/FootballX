//
//  PlayView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct PlayView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            ZStack {
                BgView()
                
                if isLandscape {
                    VStack {
                        HStack {
                            Button {
                                // PauseView()
                            } label: {
                                TopBarButton(name: "pause.fill")
                            }
                            Spacer()
                            CountView(number: 100)
                        }
                        
                        Spacer()
                        Image(.field)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    .padding()
                } else {
                    VStack {
                        HStack {
                            TopBarButton(name: "arrowshape.backward.fill")
                            Spacer()
                        }
                        Spacer()
                        Image(systemName: "iphone.landscape")
                            .font(.system(size: 120))
                            .foregroundStyle(.yellow1)
                        
                        Text("Flip your device to landscape orientation")
                            .cFont(24)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    PlayView()
}
