//
//  Text+Ext.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

extension Text {
    func cFont(_ size: CGFloat) -> some View {
        self
            .font(.system(size: size, weight: .heavy, design: .rounded))
            .foregroundStyle(.yellow1)
            .shadow(color: .black, radius: 0.7)
            .multilineTextAlignment(.center)
    }
}
