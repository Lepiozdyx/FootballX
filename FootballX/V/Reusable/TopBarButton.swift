//
//  TopBarButton.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct TopBarButton: View {
    let name: String
    
    var body: some View {
        RectangleSubstrateView(text: "", width: 60, height: 60)
            .overlay {
                Image(systemName: name)
                    .font(.system(size: 32))
                    .foregroundStyle(.yellow1)
            }
    }
}

#Preview {
    TopBarButton(name: "gearshape.fill")
}
