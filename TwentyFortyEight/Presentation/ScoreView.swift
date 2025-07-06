//
//  ScoreView.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import SwiftUI

struct ScoreView: View {
    let title: String
    let score: Int

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            Text("\(score)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(Color.gray)
        .cornerRadius(8)
    }
}

#Preview {
    ScoreView(title: "Score", score: 1234)
}
