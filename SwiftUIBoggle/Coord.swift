struct Coord: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    var adjacents: Set<Coord> {
        var temp = Set<Coord>()
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                guard (x, y) != (i, j) else { continue }
                temp.insert(Coord(i, j))
            }
        }
        return temp
    }
}
