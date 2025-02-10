//
//  RectangleSubstrateView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct RectangleSubstrateView: View {
    let text: String
    let width: CGFloat
    let height: CGFloat
    var color: Color = .green1

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: width, maxHeight: height)
            .foregroundStyle(color)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.yellow1, lineWidth: 2)
            }
            .overlay {
                Text(text)
                    .cFont(24)
            }
    }
}

#Preview {
    RectangleSubstrateView(text: "100", width: 160, height: 60)
}
