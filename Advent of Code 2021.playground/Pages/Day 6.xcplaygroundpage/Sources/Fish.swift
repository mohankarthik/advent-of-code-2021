import Foundation

public class Fish {
    // DP Cache
    static var fishPond: [Int: Int] = [:]
    
    // Fixed constants
    static let firstLifeTime = 8
    static let normalLifeTime = 6
    
    // Tracks if this fish was just generated
    private var generatedFirst: Bool = false
    // Depending on the state, it sets the current lifetime of the fish
    private var lifeTime: Int { generatedFirst ? Self.normalLifeTime : Self.firstLifeTime }
    // The initial time
    private let initialTime: Int
    // The timer left
    private let timeLeft: Int
    
    // Counts the total number of children
    public lazy var countAllChildren: Int = {
        var result = 1
        var remainingTime = timeLeft - initialTime - 1
        
        while remainingTime >= 0 {
            // Check the cache
            if let value = Fish.fishPond[remainingTime] {
                result += value
            } else {
                let newFish = Fish(leftTime: remainingTime)
                let c = newFish.countAllChildren
                Fish.fishPond[remainingTime] = c
                result += c
            }
            generatedFirst = true
            remainingTime = remainingTime - lifeTime - 1
        }
        return result
    }()
    
    public init(initialTimer: Int, leftTime: Int, generatedFirst: Bool = true) {
        self.generatedFirst = generatedFirst
        self.initialTime = initialTimer
        self.timeLeft = leftTime
    }
    
    // Brand new fish.
    private convenience init(leftTime: Int) {
        self.init(initialTimer: Self.firstLifeTime, leftTime: leftTime, generatedFirst: false)
    }
}
