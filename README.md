# TwentyFortyEight (2048 in SwiftUI)

A clean, SwiftUI-based implementation of the classic 2048 puzzle game. Swipe to move tiles, merge matching numbers, and aim for the 2048 tile. Includes a simple MVVM-ish structure, animations, and high-score persistence.

## Features

- Smooth swipe gestures for movement (up, down, left, right)
- Tile merging, scoring, and game-over detection
- High score persistence via `UserDefaults`
- Lightweight architecture with clear separation of concerns
- Basic unit tests and UI test targets

## Tech Stack

- Swift 5, SwiftUI
- Xcode project (iOS app)
- Persistence: `UserDefaults`

## Architecture

- Domain: Core game logic and data structures
  - `GameBoard` handles grid state, movement, merging, spawn logic, scoring, and game-over checks
  - `Tile` represents a single tile with `value`, `row`, and `col`
- Data: Persistence layer
  - `GameRepository` loads/saves the high score
- Presentation: SwiftUI views + state management
  - `GameViewModel` orchestrates moves, score updates, and new games
  - `GameView`, `TileView`, `ScoreView` compose the UI

## Gameplay & Controls

- Start a new game with the “New Game” button
- Swipe anywhere on the board to move tiles:
  - Left/Right: horizontal swipes
  - Up/Down: vertical swipes
- Matching adjacent tiles merge and increase your score
- A new tile (2 or 4) spawns after a successful move
- Game Over is shown when no moves remain

## Project Structure

```
TwentyFortyEight/
├─ TwentyFortyEightApp.swift              # App entry
├─ Assets.xcassets                        # App assets
├─ Domain/
│  └─ GameBoard.swift                     # Tile + grid logic, moves, score, game-over
├─ Data/
│  └─ GameRepository.swift                # High score persistence
└─ Presentation/
   ├─ GameViewModel.swift                 # ObservableObject view model
   ├─ GameView.swift                      # Main game board UI and gestures
   ├─ TileView.swift                      # Tile rendering and color mapping
   └─ ScoreView.swift                     # Score and best score chips

TwentyFortyEightTests/
└─ TwentyFortyEightTests.swift            # Sample unit test

TwentyFortyEightUITests/
├─ TwentyFortyEightUITests.swift          # Basic UI test setup
└─ TwentyFortyEightUITestsLaunchTests.swift
```

## Running the App

- Requirements:
  - Xcode 15+ (recommended)
  - iOS 16+ simulator or device
- Steps:
  1. Open `TwentyFortyEight.xcodeproj` in Xcode
  2. Select an iOS Simulator (e.g., iPhone 15)
  3. Build and run (Cmd+R)

## Tests

- Unit tests: `TwentyFortyEightTests` includes a sample test for tile spawning
- UI tests: `TwentyFortyEightUITests` provides a launch performance example
- Run from Xcode: Product → Test (Cmd+U)

## Notes & Ideas

- Improve tile colors and typography for higher values
- Add undo, haptics, or animations when merging
- Support variable board sizes (e.g., 5x5)
- Add more unit tests around merge/move edge cases
 
## Screenshot
<img width="1179" height="2556" alt="screenshot-merge" src="https://github.com/user-attachments/assets/f42d3918-0ff8-42a7-9b4b-3f8c9b307d82" />
<img width="1179" height="2556" alt="screenshot-gameover" src="https://github.com/user-attachments/assets/da74cfab-f410-457b-af96-bf2315885f12" />
<img width="1179" height="2556" alt="screenshot-start" src="https://github.com/user-attachments/assets/f7e25c02-e356-4856-83ed-b33743435814" />

