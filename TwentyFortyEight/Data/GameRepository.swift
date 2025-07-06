//
//  GameRepository.swift
//  TwentyFortyEight
//
//  Created by Zikar Nurizky on 06/07/25.
//

import Foundation

struct GameRepository {
    private let userDefaults = UserDefaults.standard
    
    private let highScoreKey = "highScore_2048"
    
    func save(highScore: Int){
        userDefaults.set(highScore, forKey: highScoreKey)
    }
    
    func loadHighScore() -> Int {
        return userDefaults.integer(forKey: highScoreKey)
    }
}
