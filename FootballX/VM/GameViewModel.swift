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
    
    init(startLevel: Int = 1) {
        let savedLevel = max(1, UserProgress.currentLevel)
        self.currentLevel = LevelData.getLevel(savedLevel)
        self.gameState = GameState(level: savedLevel, coins: UserProgress.coins)
        setupLevel()
    }
    
    // MARK: - Game Setup
    private func setupLevel() {
        // Reset grid
        var grid = [[Cell]]()
        for row in 0..<GameConstants.gridRows {
            var rowCells = [Cell]()
            for column in 0..<GameConstants.gridColumns {
                rowCells.append(Cell(row: row, column: column))
            }
            grid.append(rowCells)
        }
        gameState.grid = grid
        
        // Set game status
        gameState.gameStatus = .playing
        
        // Set initial ball position
        gameState.ballPosition = currentLevel.initialBallPosition
        let (ballRow, ballCol) = gameState.ballPosition
        gameState.grid[ballRow][ballCol].state = .ball
        
        // Set blocked cells
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
        
        // Place barrier
        gameState.grid[position.row][position.column].state = .barrier
        
        // Move ball
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
            // Update ball position
            let (currentRow, currentCol) = gameState.ballPosition
            gameState.grid[currentRow][currentCol].state = .empty
            
            gameState.ballPosition = nextMove
            gameState.grid[nextMove.row][nextMove.column].state = .ball
            
            // Check if ball reached border
            if isBorderCell(nextMove) {
                handleGameOver()
            }
        } else {
            // No available moves - player wins
            handleLevelComplete()
        }
    }
    
    private func findNextMove() -> (row: Int, column: Int)? {
        // Find path to nearest border using BFS
        var queue: [(position: (row: Int, column: Int), path: [(row: Int, column: Int)])] = []
        var visited = Set<String>()
        
        queue.append((gameState.ballPosition, [gameState.ballPosition]))
        visited.insert(positionKey(gameState.ballPosition))
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            let currentPosition = current.position
            
            // If we found a border cell, return the first step of the path
            if isBorderCell(currentPosition) {
                if current.path.count > 1 {
                    return current.path[1]
                }
                return current.path[0]
            }
            
            // Check all possible directions
            for direction in Direction.allCases {
                let nextPos = direction.nextPosition(from: currentPosition)
                
                if isValidMove(to: nextPos) && !visited.contains(positionKey(nextPos)) {
                    var newPath = current.path
                    newPath.append(nextPos)
                    queue.append((nextPos, newPath))
                    visited.insert(positionKey(nextPos))
                }
            }
        }
        
        return nil // No path found
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
    
    private func positionKey(_ position: (row: Int, column: Int)) -> String {
        "\(position.row),\(position.column)"
    }
    
    private func handleGameOver() {
        gameState.gameStatus = .lost
        isGameOver = true
    }
    
    private func handleLevelComplete() {
        gameState.gameStatus = .won
        isLevelComplete = true
        gameState.coins += currentLevel.coinsReward
        UserProgress.coins = gameState.coins
    }
}
