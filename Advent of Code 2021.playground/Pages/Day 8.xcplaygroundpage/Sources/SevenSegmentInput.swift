import Foundation

public class SevenSegmentInput {
    public var patterns: [String]
    public var values: [String]
    
    public init(line: String) {
        let split = line.components(separatedBy: " | ").map { (str) -> [String] in
            return str.components(separatedBy: " ").map { (str1) -> String in
                str1.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        patterns = split[0]
        values = split[1]
    }
}
