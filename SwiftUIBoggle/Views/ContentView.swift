import SwiftUI
import AVKit

struct ContentView: View {
    @ObservedObject var dictionary = Dictionary()
    @ObservedObject var gameController = GameController()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        switch dictionary.state {
        case .idle:
            Color.clear.onAppear(perform: dictionary.load)
        case .loading:
            ProgressView()
        case .loaded:
            VStack(spacing: 32) {
                if gameController.timeRemaining <= 0 {
                    Text("GAME OVER").font(.largeTitle)
                    ScoreView(score: gameController.score).font(.largeTitle)
                    Button("NEW GAME") {
                        gameController.newGame()
                    }
                } else {
                    GameStatusView(score: gameController.score, timeRemaining: gameController.timeRemaining)
                    CurrentEntryView(currentEntry: gameController.currentEntry.firstCapitalised)
                    LetterGridView(grid: gameController.grid, onGridItemDrag: { (coord, letter) in
                        if gameController.canNavigateToCoord(coord) {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            gameController.addToCurrentEntry(letter)
                        }
                    }, onGridDragEnd: {
                        defer {
                            gameController.resetEntry()
                        }
                        guard dictionary.isValidWord(gameController.currentEntry) else { return }
                        gameController.addAndScoreEntry()
                    })
                    .onAppear {
                        dictionary.getLongestWords(using: gameController.grid)
                    }
                    ScrollView {
                        ForEach(gameController.entries.reversed(), id: \.self) {
                            Text($0).font(.title)
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .onReceive(timer) { _ in
                gameController.tick()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension StringProtocol {
    var firstCapitalised: String {
        let lowercased = self.lowercased()
        return lowercased.prefix(1).capitalized + lowercased.dropFirst()
    }
}
