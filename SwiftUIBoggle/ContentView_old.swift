//import SwiftUI
//import AVKit
//
//struct ContentViewOld: View {
////    let wordChecker = WordChecker()
//    let successPlayer = SoundPlayer(soundFileName: "correct.m4a")
//    let failurePlayer = SoundPlayer(soundFileName: "incorrect.m4a")
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let gameLength: TimeInterval = 90
//    var allWords: [String] = []
//
//    @State private var grid = GridBuilder.build()
//    @State private var currentEntry: String = ""
//    @State private var entries: [String] = []
//    @State private var selectedCoords = Set<Coord>()
//    @State private var latestCoord: Coord? = nil
//    @State private var timeRemaining: TimeInterval = 90
//    @State private var showScore = false
//    @State private var ready: Bool = false
//    @State private var wordTree: WordTree?
//    @EnvironmentObject private var gameController: GameController
//
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    var body: some View {
//        if ready {
//            VStack {
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        ScoreView(score: gameController.score)
//                        TimeView(timeRemaining: gameController.timeRemaining)
//                    }.font(.title)
//                    Spacer()
//                    Button("New Game") {
//                        gameController.newGame()
//                    }
//                }
//                CurrentEntryView(currentEntry: currentEntry)
////                LetterGridView(grid: grid) { (coord, letter) in
////                    if selectedCoords.contains(coord) { return }
////                    guard latestCoord == nil || latestCoord?.adjacents.contains(coord) ?? false else { return }
////                    word.append(letter)
////                    selectedCoords.insert(coord)
////                    latestCoord = coord
////                }
//                Spacer()
//            }.padding(.horizontal)
//        } else {
//            ProgressView().onAppear {
//                WordTreeBuilder.build {
//                    self.wordTree = $0
//                    self.ready = true
//                }
//            }
//        }
////        VStack {
////            if wordTree == nil {
////                ProgressView().onAppear {
////                    WordTreeBuilder.build { self.wordTree = $0 }
////                }
////            } else {
////                Text("Loading complete")
////            }
////        }
////        return VStack(alignment: .center, spacing: 32) {
////            /// Score
////            HStack {
////                VStack(alignment: .leading, spacing: 0)
////                {
////                    Text("Score: \(score)").font(.largeTitle)
////                    Text("Time: \(Int(timeRemaining))s")
////                        .font(.largeTitle)
////                        .onReceive(timer) { _ in
////                            if timeRemaining > 0 {
////                                timeRemaining -= 1
////                            }
////                        }
////                }
////                Spacer()
////                BoggleButton("New Game") {
////                    newGame()
////                }
////            }
////
////            /// Letter grid
////            if timeRemaining == 0 {
////                /// Finished
//////                Spacer()
////                Text("You finished this round with \(score) points.").font(.title).multilineTextAlignment(.center)
////                Text("Your words:").font(.title)
////                /// Valid entries
////                ScrollView {
////                    LazyVGrid(columns: columns, spacing: 8) {
////                        ForEach(entries.sorted(), id: \.self) { entry in
////                            Text(entry).font(.title)
////                        }
////                    }
////                }
////                Spacer()
////            } else {
////                /// Current entry
////                Text(word.firstCapitalised).font(.largeTitle).frame(height: 50)
////                VStack {
////                    ForEach(grid.indices) { i in
////                        let letters = grid[i]
////                        VStack {
////                            HStack(alignment: .center, spacing: 0) {
////                                ForEach(letters.indices) { j in
////                                    let coord = Coord(j, i)
////                                    let letter = letters[j]
////                                    LetterSquare(letter, coord: coord).onTapGesture {
////                                        let impact = UIImpactFeedbackGenerator(style: .light)
////                                        impact.impactOccurred()
////                                        if selectedCoords.contains(coord) { return }
////                                        guard latestCoord == nil || latestCoord?.adjacents.contains(coord) ?? false else { return }
////                                        word.append(letter)
////                                        selectedCoords.insert(coord)
////                                        latestCoord = coord
////                                    }
////                                }
////                            }
////                        }
////                    }.font(.largeTitle).onAppear {
////                        wordChecker.getLongestWords(using: grid)
////                    }
////                }
////
////                /// Buttons
////                HStack(alignment: .center, spacing: 32) {
////                    BoggleButton("Check") {
////                        let entry = word.firstCapitalised
////                        if entries.contains(entry) { failurePlayer.playSound(); return }
////                        let score = wordChecker.getScore(entry)
////                        if score > 0 {
////                            entries.append(entry)
////                            successPlayer.playSound()
////                        } else {
////                            failurePlayer.playSound()
////                        }
////                        self.score += score
////                        clearEntry()
////                    }.frame(width: 150)
////                    BoggleButton("Clear") {
////                        clearEntry()
////                    }
////                    //                BoggleButton("Finish") {
////                    //                    entries.sort { (lhs, rhs) -> Bool in
////                    //                        lhs.0 < rhs.0
////                    //                    }
////                    //                }
////                }
////
////                /// Valid entries
////                ScrollView {
////                    LazyVGrid(columns: columns, spacing: 8) {
////                        ForEach(entries, id: \.self) { entry in
////                            Text(entry).font(.title)
////                        }
////                    }
////                }
////            }
////
////        }.padding(.horizontal)
//    }
//
//    func newGame() {
//        currentEntry = ""
//        entries = []
//        grid = GridBuilder.build()
//        timeRemaining = gameLength
//    }
//
//    func clearEntry() {
//        currentEntry = ""
//        selectedCoords.removeAll()
//        latestCoord = nil
//    }
//}
//
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
////
////extension StringProtocol {
////    var firstCapitalised: String {
////        let lowercased = self.lowercased()
////        return lowercased.prefix(1).capitalized + lowercased.dropFirst()
////    }
////}
