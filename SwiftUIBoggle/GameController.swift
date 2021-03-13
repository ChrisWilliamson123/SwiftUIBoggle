import SwiftUI

class GameController: ObservableObject {
    private var selectedCoords: [Coord] = []
    private let gameTime: TimeInterval = 90

    @Published private(set) var currentEntry = ""
    @Published private(set) var entries: [String] = []

    @Published private(set) var timeRemaining: TimeInterval

    @Published private(set) var score: Int = 0

    @Published var grid: Grid = GridBuilder.build()

    init() {
        timeRemaining = gameTime
    }

    func addCurrentEntry() {
        entries.append(currentEntry)
    }

    func addToCurrentEntry(_ toAdd: String) {
        currentEntry.append(toAdd)
    }

    func tick() {
        if timeRemaining > 0 { timeRemaining -= 1 }
    }

    func increaseScoreForWord(_ word: String) {
        score += scoreForWord(word)
    }

    private func scoreForWord(_ word: String) -> Int {
        switch word.count {
        case 3, 4: return 1
        case 5: return 2
        case 6: return 3
        case 7: return 5
        case 8...Int.max: return 11
        default: return 0
        }
    }

    func canNavigateToCoord(_ coord: Coord) -> Bool {
        if selectedCoords.contains(coord) { return false }
        if let last = selectedCoords.last, !last.adjacents.contains(coord) { return false }

        selectedCoords.append(coord)
        return true
    }

    func resetEntry() {
        currentEntry = ""
        selectedCoords = []
    }

    func newGame() {
        resetEntry()
        entries = []
        score = 0
        timeRemaining = gameTime
        grid = GridBuilder.build()
    }
}
