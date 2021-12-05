import Foundation

public class Point: Hashable {
    public var x: Int!
    public var y: Int!
    
    public init?(coord: String) {
        let split = coord.components(separatedBy: ",")
        guard split.count == 2 else { return nil }
        x = Int(split[0])
        y = Int(split[1])
    }
    
    public init(nx: Int, ny: Int) {
        x = nx
        y = ny
    }
    
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
