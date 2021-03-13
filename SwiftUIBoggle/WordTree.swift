import Foundation

class Node: CustomStringConvertible {
    var value: Character
    var children: [Character: Node] = [:]
    var isEndofWord: Bool = false

    init(value: Character) {
        self.value = value
    }

    func add(child: Node) {
        children[child.value] = child
    }

    var description: String {
        return "\(String(value)): \(children.keys)"
    }
}

class WordTree {

    private let roots: [Character: Node]
    weak var delegate: LongestWordsReceiving?
    private var allWords = Set<String>()
    private var gridWords = Set<String>()

    init() {
        let path = Bundle.main.path(forResource: "words", ofType: "txt")
        let text = try! String(contentsOfFile: path!, encoding: .utf8)
        let dictionary = Set(text.components(separatedBy: "\n").map({ $0.lowercased() }))
        var roots: [Character: Node] = [:]

        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value

        // Should change this to a reduce
        let letters: [Character] = (0..<26).map { Character(UnicodeScalar(aCode + $0)!) }
        letters.forEach({
            roots[$0] = Node(value: $0)
        })

        for word in dictionary {
            allWords.insert(word)
            guard let firstChar = word.first, var currentNode = roots[firstChar] else { continue }
            for character in String(word.dropFirst()) {
                if let childNode = currentNode.children[character] {
                    currentNode = childNode
                    continue
                }
                let child = Node(value: character)
                currentNode.add(child: child)
                currentNode = child
            }
            currentNode.isEndofWord = true
        }
        self.roots = roots
    }

    func isValidWord(_ word: String) -> Bool {
        guard let first = word.first, var currentNode = roots[first] else { return false }
        for character in String(word.dropFirst()) {
            guard let child = currentNode.children[character] else { return false }
            currentNode = child
        }
        return currentNode.isEndofWord
    }

    func getLongestWords(using grid: Grid) {
        gridWords.removeAll()
        DispatchQueue.global().async {
            for x in 0..<grid.count {
                for y in 0..<grid[x].count {
                    let startPoint = Coord(x, y)
                    let startString = grid[startPoint.x][startPoint.y].lowercased()
                    if startString == "Qu" {
                        let startNode = self.roots["q"]!
                        let secondNode = startNode.children["u"]!
                        self.traverse(grid: grid, start: startPoint, visited: [], treeNode: secondNode)
                        return
                    }
                    let startChar = Character(grid[startPoint.x][startPoint.y].lowercased())
                    self.traverse(grid: grid, start: startPoint, visited: [], treeNode: self.roots[startChar]!)
                }
            }
            print("Setting longest words on Dictionary class.")
            self.delegate?.longestWords = Array(self.gridWords.sorted(by: { $0.count > $1.count }).prefix(10))
            print(self.delegate?.longestWords)
        }
    }

    func traverse(grid: [[String]], start: Coord, visited: [Coord], treeNode: Node) {
        let adjacents = getAdjacents(of: start, in: grid)
        if adjacents.count > 0 {
            for adjacentCoord in adjacents {
                if visited.contains(adjacentCoord) { continue }
                let adjacentChar = Character(grid[adjacentCoord.x][adjacentCoord.y].lowercased())
                if let child = treeNode.children[adjacentChar] {
                    traverse(grid: grid, start: adjacentCoord, visited: visited + [start], treeNode: child)
                }
            }
        }
        let word = (visited.map({ grid[$0.x][$0.y] }).joined() + grid[start.x][start.y]).lowercased()
        if visited.count >= 2 && allWords.contains(word) {
            self.gridWords.insert(word)
        }
    }

    func getAdjacents(of coord: Coord, in grid: [[String]]) -> [Coord] {
        var temp = [Coord]()
        let x = coord.x
        let y = coord.y
        for i in x-1...x+1 where i >= 0 && i < grid.count {
            for j in y-1...y+1 where j >= 0 && j < grid[i].count {
                guard (x, y) != (i, j) else { continue }
                temp.append(Coord(i, j))
            }
        }
        return temp
    }
}
