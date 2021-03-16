import SwiftUI

struct LetterSquareView: View {
    let letter: String

    init(_ letter: String) {
        self.letter = letter
    }

    var body: some View {
        Text(letter.firstCapitalised)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width: 64, height: 64)
            .background(Color("Bone"))
            .clipped()
            .cornerRadius(6)
    }
}
