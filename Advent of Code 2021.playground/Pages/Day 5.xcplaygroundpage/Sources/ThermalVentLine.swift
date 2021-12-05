import Foundation

public class ThermalVentLine {
    public var start: Point!
    public var end: Point!
    
    public init?(line: String) {
        let split = line.components(separatedBy: " -> ")
        guard split.count == 2 else { return nil }
        start = Point(coord: split[0])
        end = Point(coord: split[1])
    }
}
