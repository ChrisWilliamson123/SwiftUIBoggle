import SwiftUI

struct LetterSquareView: View {
    let letter: String
    let offset: CGPoint

    init(_ letter: String, offset: CGPoint) {
        self.letter = letter
        self.offset = offset
    }

    var body: some View {
        Text(letter.firstCapitalised)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width: 64, height: 64)
            .background(Color("Bone"))
            .clipped()
            .cornerRadius(6)
            .offset(x: offset.x, y: offset.y)
    }
}
