//
//  CustomToggleView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct CustomToggleView: View {
    var isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text("OFF")
                .cFont(24)
            
            Button {
                withAnimation(.spring(duration: 0.3)) {
                    action()
                }
            } label: {
                Capsule()
                    .frame(width: 90, height: 50)
                    .foregroundStyle(.yellow1)
                    .overlay(alignment: isEnabled ? .trailing : .leading) {
                        Capsule()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(isEnabled ? .green1 : .red)
                            .overlay {
                                Capsule()
                                    .stroke(Color.black, lineWidth: 1)
                            }
                            .padding(.horizontal, 2)
                    }
            }
            .buttonStyle(.plain)
            
            Text("ON")
                .cFont(24)
        }
    }
}

#Preview {
    CustomToggleView(isEnabled: true, action: {})
}
