//
//  BgView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct BgView: View {
    var body: some View {
        Image(.bgMain)
            .resizable()
            .ignoresSafeArea()
    }
}

#Preview {
    BgView()
}
