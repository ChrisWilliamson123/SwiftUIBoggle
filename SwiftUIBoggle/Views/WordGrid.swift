//
//  WordGrid.swift
//  SwiftUIBoggle
//
//  Created by Chris Williamson on 16/03/2021.
//

import SwiftUI

struct WordGrid: View {
    let columns: [GridItem]
    let words: [String]
    let numberOfColumns: Int

    init(words: [String], numberOfColumns: Int) {
        self.words = words
        self.numberOfColumns = numberOfColumns
        self.columns = Array(repeating: GridItem(.flexible()), count: numberOfColumns)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(words, id: \.self) {
                    Text($0.capitalized(with: .current)).font(.title)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WordGrid_Previews: PreviewProvider {
    static var previews: some View {
        WordGrid(words: ["butter", "cake", "egg", "scone", "margerine", "chicken", "mixer"], numberOfColumns: 2)
    }
}
