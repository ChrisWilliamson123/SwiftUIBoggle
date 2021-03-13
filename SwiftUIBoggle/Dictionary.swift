import Foundation

class Dictionary: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded
    }

    @Published private(set) var state: State = .idle

    private var tree: WordTree? {
        didSet {
            DispatchQueue.main.async {
                self.state = .loaded
            }
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

//    func getLongestWords(using grid: Grid) {
//
//    }
}
