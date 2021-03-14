import SwiftUI
import UIKit

struct LetterGridView: View {
    let grid: Grid
    let onGridItemDrag: (Coord, String) -> ()
    let onGridDragEnd: () -> ()

    @State var highlighted: Coord? = nil

    @GestureState private var location: CGPoint = .zero

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 8) {
                ForEach(grid.indices, id: \.self) { y in
                    let letters = grid[y]
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(letters.indices, id: \.self) { x in
                            let letter = letters[x]
                            let coord = Coord(x, y)
                            GeometryReader { geometry -> LetterSquareView in
                                let insetFrame = geometry.frame(in: .global).inset(by: UIEdgeInsets(all: 10))
                                if insetFrame.contains(self.location) && self.highlighted != coord {
                                    DispatchQueue.main.async {
                                        let impact = UIImpactFeedbackGenerator(style: .light)
                                        impact.impactOccurred()
                                        self.onGridItemDrag(coord, letter)
                                        self.highlighted = coord
                                    }
                                }
                                return LetterSquareView(letter)
                            }.frame(width: 64, height: 64)
                        }
                    }
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global).updating($location) { (value, state, transaction) in
                state = value.location
            }.onEnded({ _ in
                onGridDragEnd()
                self.highlighted = nil
            }))
        }
        .padding()
        .background(Color(red: 0.93, green: 0.51, blue: 0.09))
        .clipped()
        .cornerRadius(8)
    }
}

struct LetterGridView_Previews: PreviewProvider {
    static var previews: some View {
        LetterGridView(grid: [
            ["A", "B", "C", "D"],
            ["E", "F", "G", "H"],
            ["I", "J", "K", "L"],
            ["M", "N", "O", "P"],
        ], onGridItemDrag: { (coord, letter) in
            print(coord, letter)
        }, onGridDragEnd: {
            print("Drag ended")
        })
    }
}

extension UIEdgeInsets {
    init(all inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}
