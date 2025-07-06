//
//  TwentyFortyEightTests.swift
//  TwentyFortyEightTests
//
//  Created by Zikar Nurizky on 06/07/25.
//

import XCTest
@testable import TwentyFortyEight

final class TwentyFortyEightTests: XCTestCase {
    func testSpawTile_OnEmptyBoard_ShouldContainOneTile() {
        var sut = GameBoard(size: 4)
        
        sut.spawnTile()
        
        let tileCount = sut.grid.flatMap { $0 }.compactMap { $0 }.count
        XCTAssertEqual(tileCount, 1, "After spawning one tile on an empty board, the tile count should be 1.")
        
        
    }

}
