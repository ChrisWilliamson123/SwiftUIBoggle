import SwiftUI

struct CurrentEntryView: View {
    let currentEntry: String

    var body: some View {
        Text(currentEntry).font(.largeTitle).fontWeight(.bold).frame(height: 50)
    }
}
