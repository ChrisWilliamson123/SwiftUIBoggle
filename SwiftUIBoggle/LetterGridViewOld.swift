////
////  LetterGridView.swift
////  SwiftUIBoggle
////
////  Created by Chris Williamson on 14/02/2021.
////
//
//import SwiftUI
//
//struct LetterGridViewOld: View {
//    let grid: [[String]]
////    let selectionHandler: (Coord, String) -> Void
//
//    var body: some View {
//        VStack {
//            ForEach(grid.indices) { i in
//                let letters = grid[i]
//                HStack(alignment: .center, spacing: 0) {
//                    ForEach(letters.indices) { j in
//                        let coord = Coord(j, i)
//                        let letter = letters[j]
//                        LetterSquare(letter, coord: coord).onTapGesture {
//                            /// Haptics
//                            let impact = UIImpactFeedbackGenerator(style: .light)
//                            impact.impactOccurred()
//
//                            /// Selection Handler
////                            selectionHandler(coord, letter)
//                            //                                if selectedCoords.contains(coord) { return }
//                            //                                guard latestCoord == nil || latestCoord?.adjacents.contains(coord) ?? false else { return }
//                            //                                word.append(letter)
//                            //                                selectedCoords.insert(coord)
//                            //                                latestCoord = coord
//                        }
//                    }
//                }
//            }.font(.largeTitle)
//        }
//    }
//}
//
////struct LetterGridView_Previews: PreviewProvider {
////    static var previews: some View {
////        LetterGridView(grid: [
////            ["A", "B", "C", "D"],
////            ["E", "F", "G", "H"],
////        ])
////    }
////}
