//
//  TileView.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import SwiftUI

struct TileView: View {
    let tile: Tile

    var body: some View {
        Text("\(tile.value)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .cornerRadius(8)
    }

    private var backgroundColor: Color {
        switch tile.value {
        case 2:
            return .red
        case 4:
            return .blue
        case 8:
            return .green
        case 16:
            return .orange
        case 32:
            return .purple
        case 64:
            return .yellow
        case 128:
            return .pink
        case 256:
            return .brown
        case 512:
            return .black
        case 1024:
            return .white
        default:
            return .indigo
        }
    }
}

//#Preview {
//    TileView()
//}
