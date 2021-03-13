import SwiftUI

struct ScoreView: View {
    var score: Int

    var body: some View {
        Text("\(score)").font(.largeTitle).fontWeight(.semibold)
    }
}
