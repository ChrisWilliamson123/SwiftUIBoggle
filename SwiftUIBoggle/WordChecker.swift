import Foundation

class WordChecker {
    let words: Set<String>
    var trees: [Character: Node]
    var grid: [[String]]? {
        didSet {
            if treeReady && allWords.isEmpty {
                guard let grid = self.grid else { return }
                getLongestWords(using: grid)
            }
        }
    }
    var treeReady: Bool = false
    var allWords: [String] = []

    init() {
        let path = Bundle.main.path(forResource: "words", ofType: "txt")
        let text = try! String(contentsOfFile: path!, encoding: .utf8)
        self.words = Set(text.components(separatedBy: "\n").map({ $0.lowercased() }))
        print("Dictionary filled")

        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let letters: [Character] = (0..<26).map { Character(UnicodeScalar(aCode + $0)!) }

        trees = [:]
        letters.forEach({
            trees[$0] = Node(value: $0)
        })
        buildTrees()
    }

    func buildTrees() {
        DispatchQueue.global().async {
            for word in self.words {
                guard let firstChar = word.first, var currentNode = self.trees[firstChar] else { continue }
                for character in String(word.dropFirst()) {
                    if let childNode = currentNode.children[character] {
                        currentNode = childNode
                    } else {
                        let child = Node(value: character)
                        currentNode.add(child: child)
                        currentNode = child
                    }
                }
                currentNode.isEndofWord = true
            }
            self.treeReady = true
            if let grid = self.grid, self.allWords.isEmpty {
                self.getLongestWords(using: grid)
            }
        }
    }

    func doesWordExistInTree(_ word: String) -> Bool {
        guard let first = word.first, var currentNode = trees[first] else { return false }
        for character in String(word.dropFirst()) {
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                return false
            }
        }
        if currentNode.isEndofWord { return true }
        return false
    }

    func traverseWordTree(start: Node, wordSoFar: String = "") {
        let wordSoFar = wordSoFar + String(start.value)

        if start.isEndofWord { print(wordSoFar) }
        start.children.forEach({ traverseWordTree(start: $0.value, wordSoFar: wordSoFar) })
    }

    func getScore(_ word: String) -> Int {
        guard word.count > 2, words.contains(word.lowercased()) else { return 0 }
        switch word.count {
        case 3, 4: return 1
        case 5: return 2
        case 6: return 3
        case 7: return 5
        case 8...Int.max: return 11
        default: return 0
        }
    }

    func getLongestWords(using grid: [[String]]) {
        for x in 0..<grid.count {
            for y in 0..<grid[x].count {
                let startPoint = Coord(x, y)
                let startString = grid[startPoint.x][startPoint.y].lowercased()
                if startString == "Qu" {
                    let startNode = trees["q"]!
                    let secondNode = startNode.children["u"]!
                    traverse(grid: grid, start: startPoint, visited: [], treeNode: secondNode)
                    return
                }
                let startChar = Character(grid[startPoint.x][startPoint.y].lowercased())
                traverse(grid: grid, start: startPoint, visited: [], treeNode: trees[startChar]!)
            }
        }
        print(Set(self.allWords).sorted(by: { (lhs, rhs) -> Bool in
            lhs.count > rhs.count
        }))
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

    func traverse(grid: [[String]], start: Coord, visited: [Coord], treeNode: Node) {
//        let startItem = grid[start.x][start.y]
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
        if visited.count >= 2 && words.contains(word) {
            self.allWords.append(word)
        }
    }
}



