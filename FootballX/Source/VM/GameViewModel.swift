//
//  GameViewModel.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var gameState: GameState
    @Published private(set) var isGameOver = false
    @Published private(set) var isLevelComplete = false
    @Published var isPaused = false
    
    private var currentLevel: Level
    private let coinManager = CoinManager.shared
    
    init(startLevel: Int = 1) {
        let savedLevel = max(1, UserProgress.currentLevel)
        self.currentLevel = LevelData.getLevel(savedLevel)
        self.gameState = GameState(level: savedLevel, coins: UserProgress.coins)
        setupLevel()
    }
    
    // MARK: - Game Setup
    private func setupLevel() {
        var grid = [[Cell]]()
        for row in 0..<GameConstants.gridRows {
            var rowCells = [Cell]()
            for column in 0..<GameConstants.gridColumns {
                rowCells.append(Cell(row: row, column: column))
            }
            grid.append(rowCells)
        }
        
        gameState.grid = grid
        gameState.gameStatus = .playing
        
        gameState.ballPosition = currentLevel.initialBallPosition
        let (ballRow, ballCol) = gameState.ballPosition
        gameState.grid[ballRow][ballCol].state = .ball
        
        for (row, col) in currentLevel.blockedCells {
            guard row >= 0 && row < GameConstants.gridRows,
                  col >= 0 && col < GameConstants.gridColumns else { continue }
            gameState.grid[row][col].state = .blocked
        }
    }
    
    // MARK: - Game Actions
    func cellTapped(at position: (row: Int, column: Int)) {
        guard gameState.gameStatus == .playing,
              isValidPosition(position),
              gameState.grid[position.row][position.column].state == .empty else {
            return
        }
        
        gameState.grid[position.row][position.column].state = .barrier
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.moveBall()
        }
    }
    
    func pauseGame() {
        isPaused = true
        gameState.gameStatus = .paused
    }
    
    func resumeGame() {
        isPaused = false
        gameState.gameStatus = .playing
    }
    
    func restartLevel() {
        setupLevel()
        isGameOver = false
        isLevelComplete = false
        isPaused = false
    }
    
    func nextLevel() {
        currentLevel = LevelData.getLevel(gameState.currentLevel + 1)
        gameState.currentLevel += 1
        UserProgress.currentLevel = gameState.currentLevel
        setupLevel()
        isLevelComplete = false
    }
    
    // MARK: - Ball Movement Logic
    private func moveBall() {
        guard gameState.gameStatus == .playing else { return }
        
        if let nextMove = findNextMove() {
            let (currentRow, currentCol) = gameState.ballPosition
            gameState.grid[currentRow][currentCol].state = .empty
            
            gameState.ballPosition = nextMove
            gameState.grid[nextMove.row][nextMove.column].state = .ball
            
            if isBorderCell(nextMove) {
                handleGameOver()
            }
        } else {
            handleLevelComplete()
        }
    }
    
    private func findNextMove() -> (row: Int, column: Int)? {
        let currentCell = gameState.grid[gameState.ballPosition.row][gameState.ballPosition.column]
        let availableNeighbors = currentCell.getValidNeighbors(in: gameState.grid)
        
        guard !availableNeighbors.isEmpty else { return nil }
        
        if let borderMove = availableNeighbors.first(where: { isBorderCell($0) }) {
            return borderMove
        }
        
        return availableNeighbors.min { pos1, pos2 in
            let dist1 = distanceToBorder(pos1)
            let dist2 = distanceToBorder(pos2)
            return dist1 < dist2
        }
    }
    
    // MARK: - Helper Functions
    private func isValidPosition(_ position: (row: Int, column: Int)) -> Bool {
        position.row >= 0 && position.row < GameConstants.gridRows &&
        position.column >= 0 && position.column < GameConstants.gridColumns
    }
    
    private func isValidMove(to position: (row: Int, column: Int)) -> Bool {
        guard isValidPosition(position) else { return false }
        let cell = gameState.grid[position.row][position.column]
        return cell.state == .empty
    }
    
    private func isBorderCell(_ position: (row: Int, column: Int)) -> Bool {
        position.row == 0 || position.row == GameConstants.gridRows - 1 ||
        position.column == 0 || position.column == GameConstants.gridColumns - 1
    }
    
    private func distanceToBorder(_ position: (row: Int, column: Int)) -> Int {
        let (row, col) = position
        let verticalDist = min(row, GameConstants.gridRows - 1 - row)
        let horizontalDist = min(col, GameConstants.gridColumns - 1 - col)

        return (verticalDist + horizontalDist) / 2
    }
    
    private func handleGameOver() {
        gameState.gameStatus = .lost
        isGameOver = true
    }
    
    private func handleLevelComplete() {
        gameState.gameStatus = .won
        isLevelComplete = true
        coinManager.add(currentLevel.coinsReward)
    }
}
