//
//  SkinTileView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct SkinTileView: View {
    let skin: FieldSkin
    let isPurchased: Bool
    let isSelected: Bool
    let onBuy: () -> Void
    let onSelect: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            RectangleSubstrateView(text: "", width: 180, height: 200, color: .white.opacity(0.8))
            
            VStack(spacing: 30) {
                Image(skin.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.yellow1 : .clear, lineWidth: 3)
                    }
                    .overlay {
                        Text(skin.title)
                            .cFont(16)
                    }
                    
                if !isPurchased {
                    Button {
                        onBuy()
                    } label: {
                        Capsule()
                            .frame(maxWidth: 160, maxHeight: 40)
                            .foregroundStyle(.green1)
                            .overlay {
                                Capsule()
                                    .stroke(Color.yellow1, lineWidth: 2)
                            }
                            .overlay {
                                HStack {
                                    Image(.coin)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(4)
                                    Text("\(skin.price)")
                                        .cFont(24)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                } else if !isSelected {
                    Button {
                        onSelect()
                    } label: {
                        ActionView(text: "SELECT", width: 160, height: 40)
                    }
                    .buttonStyle(.plain)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(.green2)
                        .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    SkinTileView(skin: FieldSkin.init(id: 1, image: .field, price: 0, title: ""), isPurchased: true, isSelected: true, onBuy: {}, onSelect: {})
}
