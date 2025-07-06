//
//  GameViewModel.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameBoard = GameBoard(size: 4)
    @Published var highScore = 0
    
    private let repository = GameRepository()
    
    init() {
        self.highScore = repository.loadHighScore()
    }
    
    var isGameOver: Bool {
        return gameBoard.isGameOver
    }
    
    // This computed property flattens the 2D grid into a 1D array of non-optional tiles,
    // which is perfect for SwiftUI's ForEach loop.
    var tiles: [Tile] {
        gameBoard.grid.flatMap { $0 }.compactMap { $0 }
    }
    
    func newGame() {
        withAnimation {
            gameBoard = GameBoard(size: 4)
            gameBoard.spawnTile()
            gameBoard.spawnTile()
        }
    }
    
    func move(_ direction: MoveDirection){
        withAnimation {
            gameBoard.move(direction)
            if gameBoard.score > highScore {
                highScore = gameBoard.score
                repository.save(highScore: highScore)
            }
        }
    }
}
