import Foundation

protocol LongestWordsReceiving: class {
    var longestWords: [String]? { get set }
}

class Dictionary: ObservableObject, LongestWordsReceiving {
    enum State {
        case idle
        case loading
        case loaded
    }

    @Published private(set) var state: State = .idle
    var longestWords: [String]?

    private var tree: WordTree? {
        didSet {
            guard let tree = tree else { return }
            DispatchQueue.main.async {
                self.state = .loaded
            }
            tree.delegate = self
        }
    }

    func load() {
        state = .loading
        DispatchQueue.global().async {
            self.tree = WordTree()
        }
    }

    func isValidWord(_ word: String) -> Bool {
        guard word.count > 2, let tree = tree else { return false }
        return tree.isValidWord(word)
    }

    func getLongestWords(using grid: Grid) {
        print("Getting longest words")
        tree?.getLongestWords(using: grid)
    }
}
