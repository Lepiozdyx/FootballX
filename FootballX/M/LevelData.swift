//
//  LevelData.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import Foundation

struct LevelData {
    static let levels: [Level] = [
        Level(id: 1, blockedCells: [
            (0, 0), (0, 3), (0, 6), (0, 9),
            (1, 1), (1, 4), (1, 7),
            (2, 2), (2, 5), (2, 8),
            (3, 0), (3, 3), (3, 9),
            (4, 1), (4, 7)
        ]),
        Level(id: 2, blockedCells: [
            (0, 1), (0, 4), (0, 7), (0, 10),
            (1, 2), (1, 5), (1, 8),
            (2, 0), (2, 3), (2, 6),
            (3, 1), (3, 4), (3, 7),
            (4, 2)
        ]),
        // Add more levels following the pattern...
        Level(id: 10, blockedCells: [
            (0, 5),
            (2, 3),
            (3, 7),
            (4, 2),
            (6, 4)
        ])
    ]
    
    static func getLevel(_ id: Int) -> Level {
        if id <= levels.count {
            return levels[id - 1]
        } else {
            // For levels beyond predefined ones, return cycled level
            let cycledIndex = (id - 1) % levels.count
            return levels[cycledIndex]
        }
    }
}
