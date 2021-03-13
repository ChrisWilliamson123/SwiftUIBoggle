import SwiftUI

struct GameStatusView: View {
    let score: Int
    let timeRemaining: TimeInterval

    var body: some View {
        HStack {
            TimeView(timeRemaining: timeRemaining)
            Spacer()
            ScoreView(score: score)
            Spacer()
            TimeView(timeRemaining: timeRemaining).hidden()
        }
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView(score: 15, timeRemaining: 58)
    }
}
