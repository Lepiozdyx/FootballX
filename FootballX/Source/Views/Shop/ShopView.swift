//
//  ShopView.swift
//  FootballX
//
//  Created by Alex on 12.02.2025.
//

import SwiftUI

struct ShopView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var shopManager = ShopManager.shared
    @ObservedObject var coinManager: CoinManager
    
    var body: some View {
        ZStack {
            BgView()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        TopBarButton(name: "arrowshape.backward.fill")
                    }
                    Spacer()
                    CountView(number: coinManager.balance)
                }
                
                Spacer()
                
                RectangleSubstrateView(text: "", width: 450, height: 450, color: .green2)
                    .overlay(alignment: .top) {
                        RectangleSubstrateView(text: "SHOP", width: 260, height: 50, color: .green2)
                            .offset(x: 0, y: -25)
                    }
                    .overlay {
                        // Content
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(shopManager.skins) { skin in
                                        SkinTileView(
                                            skin: skin,
                                            isPurchased: shopManager.isSkinPurchased(skin),
                                            isSelected: skin.id == shopManager.selectedSkinId,
                                            onBuy: {
                                                if coinManager.spend(skin.price) {
                                                    shopManager.purchaseSkin(skin)
                                                }
                                            },
                                            onSelect: {
                                                shopManager.selectSkin(skin)
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(2)
                        }
                    }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ShopView(coinManager: CoinManager())
}
