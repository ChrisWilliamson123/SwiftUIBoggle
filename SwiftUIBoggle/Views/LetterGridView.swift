import SwiftUI

struct LetterGridView: View {
    let grid: Grid
    let onGridItemTap: (Coord, String) -> ()

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 8) {
                ForEach(grid.indices, id: \.self) { y in
                    let letters = grid[y]
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(letters.indices, id: \.self) { x in
                            let letter = letters[x]
                            let coord = Coord(x, y)
                            LetterSquareView(letter)
                                .onTapGesture {
                                    let impact = UIImpactFeedbackGenerator(style: .light)
                                    impact.impactOccurred()
                                    self.onGridItemTap(coord, letter)
                                }
                        }
                    }
                }
            }
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
        ]) { (coord, letter) in
            print(coord, letter)
        }
    }
}
