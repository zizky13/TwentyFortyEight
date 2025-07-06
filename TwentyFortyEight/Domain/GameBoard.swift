//
//  GameBoard.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import Foundation

struct Tile: Identifiable, Equatable {
    let id = UUID()
    var value: Int
    var row: Int
    var col: Int
    
    init(value: Int, row: Int, col: Int) {
        self.value = value
        self.row = row
        self.col = col
    }
    
}

struct GameBoard {
    var size: Int
    var grid: [[Tile?]]
    var score: Int = 0
    var isGameOver = false
    
    init(size: Int) {
        self.size = size
        self.grid = Array(repeating: Array(repeating: nil, count: size), count: size)
    }
    
    mutating func spawnTile() {
        //Find all index of grid tiles that contains nil
        var emptyTiles: [[Int]] = []
        
        for i in 0..<size {
            for j in 0..<size {
                if grid[i][j] == nil {
                    emptyTiles.append([i,j])
                }
            }
        }
        
        guard emptyTiles != [] else {
            return
        }
        
        //if there are no empty tiles, do nothing and return
        //Using the index found, pick a random empty index and fill it with value (2 for 90% and 4 for 10%
        // 1. Get a random INDEX from the array of empty tiles.
        //    For example, if there are 5 empty tiles, this will be a number from 0 to 4.
        let randomIndex = Int.random(in: 0..<emptyTiles.count)

        // 2. Use that random index to get the actual coordinate array.
        //    e.g., let coordinate = emptyTiles[3] which might be [1, 2]
        let coordinate = emptyTiles[randomIndex]

        // 3. Now use the elements of that coordinate array to update the grid.
        //    e.g., grid[1][2] = new Tile(...)
        grid[coordinate[0]][coordinate[1]] = Tile(value: Int.random(in: 1...10) == 1 ? 4 : 2, row: coordinate[0], col: coordinate[1])
    }
    
    private func compact(row: [Tile?]) -> [Tile?] {
        //filter out nil tiles to get only valued existing tiles
        let existingTiles = row.compactMap { $0 }
        
        //create new row with existing tiles at the beginning
        let newRow = existingTiles + Array(repeating: nil, count: size - existingTiles.count)
        
        return newRow
    }
    
    private mutating func merge(row: [Tile?]) -> [Tile?] {
        var newRow = row
        
        //iterate from left to right, up to the second-to-last tile
        for i in 0..<size - 1 {
            if let currentTile = newRow[i], let nextTile = newRow[i + 1], currentTile.value == nextTile.value {
                
                //merge adjacent tile value by doubling them
                newRow[i]?.value *= 2
                
                //update the score
                score += newRow[i]!.value
                
                
                //remove the next tile
                newRow[i + 1] = nil
            }
        }
        
        return newRow
    }
    
    private func reverse(row: [Tile?]) -> [Tile?] {
        return row.reversed()
    }
    
    private func transpose(grid: [[Tile?]]) -> [[Tile?]] {
        var newGrid: [[Tile?]] = Array(repeating: Array(repeating: nil, count: size), count: size)
        
        for i in 0..<size {
            for j in 0..<size {
                newGrid[j][i] = grid[i][j]
            }
        }
        
        return newGrid
    }
    
    private mutating func moveLeft() {
        //process each row
        for i in 0..<size {
            let row = grid[i]
            //compact the row first using compact function
            let compactedRow = compact(row: row)
            
            //then merge the compacted row
            let mergedRow = merge(row: compactedRow)
            
            //apply the final compacted row back to our grid
            grid[i] = compact(row: mergedRow)
        }
    }
    
    
    mutating func move(_ direction: MoveDirection){
        let originalGrid = grid
        switch direction {
        case .left:
            moveLeft()
        case .right:
            grid = grid.map { reverse(row: $0)}
            moveLeft()
            grid = grid.map { reverse(row: $0)}
        case .up:
            grid = transpose(grid: grid)
            moveLeft()
            grid = transpose(grid: grid)
        case .down:
            grid = transpose(grid: grid)
            grid = grid.map { reverse(row: $0)}
            moveLeft()
            grid = grid.map { reverse(row: $0)}
            grid = transpose(grid: grid)
        }
        
        for i in 0..<size {
            for j in 0..<size {
                grid[i][j]?.row = i
                grid[i][j]?.col = j
            }
        }
   
        
        if grid != originalGrid {
            spawnTile()
            checkForGameOver()
        }
    }
    
    private mutating func checkForGameOver() {
        let hasEmptyTile = grid.flatMap { $0 }.contains(where: { $0 == nil })
        if hasEmptyTile {
            self.isGameOver = false
            return
        }
        
        for i in 0..<size {
            for j in 0..<size {
                let currentTile = grid[i][j]
                if i < size - 1, let nextTile = grid[i + 1][j], currentTile?.value == nextTile.value {
                    self.isGameOver = false
                    return
                }
                
                if j < size - 1, let nextTile = grid[i][j + 1], currentTile?.value == nextTile.value {
                    self.isGameOver = false
                    return
                }
            }
        }
        
        self.isGameOver = true
    }
}

enum MoveDirection {
    case up, down, left, right
}
