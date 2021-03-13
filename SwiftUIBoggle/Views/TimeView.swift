import SwiftUI

struct TimeView: View {
    let timeRemaining: TimeInterval

    var body: some View {
        Label(timeRemaining.hoursAndMinutesString(), systemImage: "hourglass").font(.title)
    }
}

extension TimeInterval{

    func hoursAndMinutesString() -> String {

        let time = Int(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60

        return String(format: "%0.1d:%0.2d",minutes,seconds)
    }
}
