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
                } else {
                    GameStatusView(score: gameController.score, timeRemaining: gameController.timeRemaining)
                    CurrentEntryView(currentEntry: gameController.currentEntry.firstCapitalised)
                    LetterGridView(grid: gameController.grid, onGridItemTap: { (coord, letter) in
                        if gameController.canNavigateToCoord(coord) {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            gameController.addToCurrentEntry(letter)
                        }
                    })
                    HStack(spacing: 32) {
                        Button("Check") {
                            defer {
                                gameController.resetEntry()
                            }
                            print(gameController.currentEntry)
                            guard dictionary.isValidWord(gameController.currentEntry) else { return }
                            gameController.addCurrentEntry()
                            gameController.increaseScoreForWord(gameController.currentEntry)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(40)
                        Button("Clear") {
                            gameController.resetEntry()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(40)
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
