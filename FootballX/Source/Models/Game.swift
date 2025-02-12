//
//  Game.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import Foundation

// MARK: - Cell Model
struct Cell: Identifiable, Equatable {
    let id: UUID
    let row: Int
    let column: Int
    var state: CellState
    
    init(row: Int, column: Int, state: CellState = .empty) {
        self.id = UUID()
        self.row = row
        self.column = column
        self.state = state
    }
}

// MARK: - Cell State
enum CellState: Equatable {
    case empty
    case blocked
    case ball
    case barrier
}

// MARK: - Game Level
struct Level: Identifiable {
    let id: Int
    let blockedCells: [(row: Int, column: Int)]
    let initialBallPosition: (row: Int, column: Int)
    let coinsReward: Int
    
    init(id: Int, blockedCells: [(Int, Int)], initialBallPosition: (Int, Int) = (3, 5), coinsReward: Int = 10) {
        self.id = id
        self.blockedCells = blockedCells
        self.initialBallPosition = initialBallPosition
        self.coinsReward = coinsReward
    }
}

// MARK: - Game State
struct GameState {
    var currentLevel: Int
    var coins: Int
    var grid: [[Cell]]
    var ballPosition: (row: Int, column: Int)
    var gameStatus: GameStatus
    
    init(level: Int = 1, coins: Int = 0) {
        self.currentLevel = level
        self.coins = coins
        self.grid = GameState.createInitialGrid()
        self.ballPosition = (3, 5) // Initial ball position
        self.gameStatus = .playing
    }
    
    static func createInitialGrid() -> [[Cell]] {
        var grid: [[Cell]] = []
        for row in 0..<7 {
            var rowCells: [Cell] = []
            for column in 0..<11 {
                rowCells.append(Cell(row: row, column: column))
            }
            grid.append(rowCells)
        }
        return grid
    }
}

// MARK: - Game Status
enum GameStatus {
    case playing
    case won
    case lost
    case paused
}

// MARK: - Movement Direction
enum Direction: CaseIterable {
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
    case upLeft
    
    func nextPosition(from current: (row: Int, column: Int)) -> (row: Int, column: Int) {
        let (row, col) = current
        let isEvenRow = row % 2 == 0
        
        switch self {
        case .up:
            return (row - 1, col)
        case .upRight:
            return (row - 1, isEvenRow ? col + 1 : col)
        case .right:
            return (row, col + 1)
        case .downRight:
            return (row + 1, isEvenRow ? col + 1 : col)
        case .down:
            return (row + 1, col)
        case .downLeft:
            return (row + 1, isEvenRow ? col : col - 1)
        case .left:
            return (row, col - 1)
        case .upLeft:
            return (row - 1, isEvenRow ? col : col - 1)
        }
    }
}

struct FieldSkin: Identifiable {
    let id: Int
    let image: ImageResource
    let price: Int
    let title: String
}

// MARK: - Constants
struct GameConstants {
    static let gridRows = 7
    static let gridColumns = 11
}

