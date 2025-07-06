//
//  GameView.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    // Define a consistent spacing value
    private let TILE_SPACING: CGFloat = 8.0

    var body: some View {
        VStack(spacing: TILE_SPACING) {
            Text("2048")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button("New Game", action: viewModel.newGame)
                .buttonStyle(.borderedProminent)

            // The Game Board area
            GeometryReader { geometry in
                let boardSize = geometry.size.width
                let tileSize = (boardSize - (TILE_SPACING * CGFloat(viewModel.gameBoard.size + 1))) / CGFloat(viewModel.gameBoard.size)

                ZStack {
                    // Layer 1: The static background grid
                    VStack(spacing: TILE_SPACING) {
                        ForEach(0..<viewModel.gameBoard.size, id: \.self) { _ in
                            HStack(spacing: TILE_SPACING) {
                                ForEach(0..<viewModel.gameBoard.size, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black.opacity(0.3))
                                        .frame(width: tileSize, height: tileSize)
                                }
                            }
                        }
                    }

                    // Layer 2: The dynamic, animated tiles
                    ForEach(viewModel.tiles) { tile in
                        TileView(tile: tile)
                            .frame(width: tileSize, height: tileSize)
                            .position(
                                x: calculatePosition(for: tile.col, size: tileSize),
                                y: calculatePosition(for: tile.row, size: tileSize)
                            )
                            .id("\(tile.id)-\(tile.value)")
                            .transition(.scale)
                    }
                    
                    // Layer 3: The Game Over overlay
                    if viewModel.isGameOver {
                        VStack {
                            Text("Game Over")
                                .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                            Button("Play Again", action: viewModel.newGame)
                                .buttonStyle(.borderedProminent).padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            // ... your gesture logic remains the same
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height
                            
                            if abs(horizontalAmount) > abs(verticalAmount) {
                                viewModel.move(horizontalAmount < 0 ? .left : .right)
                            } else {
                                viewModel.move(verticalAmount < 0 ? .up : .down)
                            }
                        }
                )
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(8)
            .aspectRatio(1, contentMode: .fit) // Make the board square

            Spacer()
        }
        .padding()
        .onAppear(perform: viewModel.newGame)
    }

    // Helper function to calculate the x or y coordinate for a tile
    private func calculatePosition(for index: Int, size: CGFloat) -> CGFloat {
        return (size / 2) + CGFloat(index) * (size + TILE_SPACING) + TILE_SPACING
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
