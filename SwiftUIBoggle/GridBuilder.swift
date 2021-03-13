typealias Grid = [[String]]

class GridBuilder {

    static let cubes = [
        ["a", "a", "c", "i", "o", "t"],
        ["a", "b", "i", "l", "t", "y"],
//        ["a", "b", "j", "m", "o", "qu"],
        ["qu", "qu", "qu", "qu", "qu", "qu"],
        ["a", "c", "d", "e", "m", "p"],
        ["a", "c", "e", "l", "r", "s"],
        ["a", "d", "e", "n", "v", "z"],
        ["a", "h", "m", "o", "r", "s"],
        ["b", "i", "f", "o", "r", "x"],
        ["d", "e", "n", "o", "s", "w"],
        ["d", "k", "n", "o", "t", "u"],
        ["e", "e", "f", "h", "i", "y"],
        ["e", "g", "k", "l", "u", "y"],
        ["e", "g", "i", "n", "t", "v"],
        ["e", "h", "i", "n", "p", "s"],
        ["e", "l", "p", "s", "t", "u"],
        ["g", "i", "l", "r", "u", "w"]
    ]

    static func build() -> [[String]] {
        let squares = cubes.shuffled().map({ $0.randomElement()! })
        let grid = Array(repeating: Array(repeating: "X", count: 4), count: 4)

        var iter = squares.makeIterator()
        return grid.map({ $0.compactMap({ _ in iter.next() }) })
    }
}
