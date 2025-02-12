//
//  CountView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct CountView: View {
    let number: Int
    
    var body: some View {
        HStack {
            RectangleSubstrateView(text: "", width: 50, height: 50)
                .overlay {
                    Image(.coin)
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .shadow(radius: 1)
                }
            
            RectangleSubstrateView(text: "\(number)", width: 120, height: 50)
        }
    }
}

#Preview {
    CountView(number: 100)
}
