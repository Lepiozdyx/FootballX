//
//  PlayView.swift
//  FootballX
//
//  Created by Alex on 10.02.2025.
//

import SwiftUI

struct PlayView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = GameViewModel()
    @ObservedObject var coinManager: CoinManager
    
    var body: some View {
        ZStack(alignment: .top) {
            BgView()
            
            VStack {
                // MARK: Top bar
                HStack {
                    Button {
                        viewModel.pauseGame()
                    } label: {
                        TopBarButton(name: "pause.fill")
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Spacer()
                        Spacer()
                        RectangleSubstrateView(
                            text: "Level \(viewModel.gameState.currentLevel)",
                            width: 140,
                            height: 50
                        )
                        Spacer()
                        CountView(number: coinManager.balance)
                    }
                }
                .padding([.horizontal, .top])
                
                // MARK: Game board
                Spacer()
                GameBoardView(
                    grid: viewModel.gameState.grid,
                    onCellTap: { row, column in
                        viewModel.cellTapped(at: (row, column))
                    }
                )
                Spacer()
            }
            
            // MARK: - Game overlays
            
            // MARK: PauseView
            if viewModel.isPaused {
                PauseView(
                    resumeAction: {viewModel.resumeGame()},
                    menuAction: {dismiss()}
                )
            }
            
            // MARK: LevelCompleteView
            if viewModel.isLevelComplete {
                LevelCompleteView(
                    level: viewModel.gameState.currentLevel,
                    coins: coinManager.balance,
                    nextLevelAction: {viewModel.nextLevel()},
                    menuAction: {dismiss()}
                )
            }
            
            // MARK: GameOverView
            if viewModel.isGameOver {
                GameOverView(
                    retryAction: {viewModel.restartLevel()},
                    menuAction: {dismiss()}
                )
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
#Preview {
    PlayView(coinManager: CoinManager())
}
