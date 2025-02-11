//
//  GameCellView.swift
//  FootballX
//
//  Created by Alex on 11.02.2025.
//

import SwiftUI

struct GameCellView: View {
    let cell: Cell
    let size: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(backgroundColor)
                .overlay {
                    cellContent
                }
                .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var cellContent: some View {
        switch cell.state {
        case .empty:
            Circle()
                .strokeBorder(Color.yellow1, lineWidth: 2)
        case .blocked:
            ZStack {
                Circle()
                    .fill(Color.green1)
                Circle()
                    .strokeBorder(Color.yellow1, lineWidth: 2)
            }
        case .ball:
            ZStack {
                Circle()
                    .strokeBorder(Color.yellow1, lineWidth: 2)
                Image(.ball)
                    .resizable()
                    .scaledToFit()
                    .padding(4)
            }
        case .barrier:
            ZStack {
                Circle()
                    .strokeBorder(Color.yellow1, lineWidth: 2)
                Image(systemName: "xmark")
                    .font(.system(size: size * 0.5, weight: .bold))
                    .foregroundStyle(.yellow1)
            }
        }
    }
    
    private var backgroundColor: Color {
        switch cell.state {
        case .empty:
            return .white.opacity(0.9)
        case .blocked:
            return .green1
        case .ball, .barrier:
            return .green1
        }
    }
}

#Preview {
    HStack {
        GameCellView(cell: Cell(row: 0, column: 0, state: .empty), size: 50) {}
        GameCellView(cell: Cell(row: 0, column: 0, state: .blocked), size: 50) {}
        GameCellView(cell: Cell(row: 0, column: 0, state: .ball), size: 50) {}
        GameCellView(cell: Cell(row: 0, column: 0, state: .barrier), size: 50) {}
    }
    .padding()
    .background(Color.green2)
}
