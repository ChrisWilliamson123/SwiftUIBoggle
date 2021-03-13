import Foundation

class WordTreeBuilder {
    static func build(completion: @escaping  (WordTree) -> Void) {
        DispatchQueue.global().async {
            let tree = WordTree()
            completion(tree)
        }
    }
}
