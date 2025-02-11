//
//  ActionView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct ActionView: View {
    let text: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Capsule()
            .frame(maxWidth: width, maxHeight: height)
            .foregroundStyle(.green1)
            .overlay {
                Capsule()
                    .stroke(Color.yellow1, lineWidth: 2)
            }
            .overlay {
                Text(text)
                    .cFont(24)
            }
    }
}

#Preview {
    ActionView(text: "Text", width: 160, height: 60)
}
