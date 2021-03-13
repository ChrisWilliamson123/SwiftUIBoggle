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
