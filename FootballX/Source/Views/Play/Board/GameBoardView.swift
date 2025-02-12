//
//  GameBoardView.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject private var skinManager = ShopManager.shared
    
    let grid: [[Cell]]
    let onCellTap: (Int, Int) -> Void
    
    private let edgeInset: CGFloat = 10
    private let cellSpacing: CGFloat = 2
    
    var body: some View {
        GeometryReader { geometry in
            let size = calculateBoardSize(from: geometry.size)
            
            ZStack {
                Image(skinManager.currentSkin.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
                
                let cellSize = calculateCellSize(boardSize: size)
                
                ForEach(0..<GameConstants.gridRows, id: \.self) { row in
                    ForEach(0..<GameConstants.gridColumns, id: \.self) { column in
                        GameCellView(
                            cell: grid[row][column],
                            size: cellSize
                        ) {
                            onCellTap(row, column)
                        }
                        .position(
                            x: calculateXPosition(
                                column: column,
                                row: row,
                                cellSize: cellSize,
                                boardWidth: size.width
                            ),
                            y: calculateYPosition(
                                row: row,
                                cellSize: cellSize,
                                boardHeight: size.height
                            )
                        )
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(1.6, contentMode: .fit)
    }
    
    private func calculateBoardSize(from frameSize: CGSize) -> CGSize {
        let aspectRatio: CGFloat = 1.6 // Соотношение сторон поля (ширина/высота)
        
        if frameSize.width / frameSize.height > aspectRatio {
            // Ограничено по высоте
            let height = frameSize.height
            let width = height * aspectRatio
            return CGSize(width: width, height: height)
        } else {
            // Ограничено по ширине
            let width = frameSize.width
            let height = width / aspectRatio
            return CGSize(width: width, height: height)
        }
    }
    
    private func calculateCellSize(boardSize: CGSize) -> CGFloat {
        let effectiveWidth = boardSize.width - (edgeInset * 2)
        let effectiveHeight = boardSize.height - (edgeInset * 2)
        
        let maxColumns = CGFloat(GameConstants.gridColumns)
        let maxRows = CGFloat(GameConstants.gridRows)
        
        // Учитываем смещение для нечетных строк при расчете ширины
        let widthSize = (effectiveWidth - cellSpacing * (maxColumns - 1)) / (maxColumns + 0.5)
        let heightSize = (effectiveHeight - cellSpacing * (maxRows - 1)) / maxRows
        
        return min(widthSize, heightSize)
    }
    
    private func calculateXPosition(column: Int, row: Int, cellSize: CGFloat, boardWidth: CGFloat) -> CGFloat {
        let totalCellWidth = cellSize + cellSpacing
        let startX = edgeInset + cellSize/2
        
        let baseX = startX + CGFloat(column) * totalCellWidth
        let offset = row.isMultiple(of: 2) ? 0 : totalCellWidth/2
        
        return baseX + offset
    }
    
    private func calculateYPosition(row: Int, cellSize: CGFloat, boardHeight: CGFloat) -> CGFloat {
        let totalCellHeight = cellSize + cellSpacing
        let startY = edgeInset + cellSize/2
        
        return startY + CGFloat(row) * totalCellHeight
    }
}

#Preview {
    GameBoardView(
        grid: GameState.createInitialGrid(),
        onCellTap: { _, _ in }
    )
    .padding()
}
