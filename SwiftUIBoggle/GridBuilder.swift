typealias Grid = [[String]]

class GridBuilder {

    static let cubes = [
        ["e", "l", "t", "y", "t", "r"],
        ["z", "l", "r", "h", "n", "n"],
        ["j", "o", "o", "b", "a", "b"],
        ["t", "s", "e", "o", "i", "s"],
        ["g", "n", "e", "e", "a", "a"],
        ["w", "r", "e", "t", "h", "v"],
        ["c", "o", "u", "m", "i", "t"],
        ["p", "c", "h", "o", "s", "a"],
        ["a", "w", "t", "o", "t", "o"],
        ["r", "e", "i", "l", "x", "d"],
        ["e", "g", "h", "w", "n", "e"],
        ["e", "e", "s", "u", "n", "i"],
        ["y", "v", "d", "r", "e", "l"],
        ["s", "y", "i", "d", "t", "t"],
        ["f", "a", "s", "p", "f", "k"],
        ["n", "h", "i", "u", "qu", "m"],
    ]

    static func build() -> [[String]] {
        let squares = cubes.shuffled().map({ $0.randomElement()! })
        let grid = Array(repeating: Array(repeating: "X", count: 4), count: 4)

        var iter = squares.makeIterator()
        return grid.map({ $0.compactMap({ _ in iter.next() }) })
    }
}
