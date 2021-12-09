//: [Previous](@previous)

import Foundation

/**
 ## Day 9: Smoke Basin ---
 
 ### Part 1
 
 These caves seem to be lava tubes. Parts are even still volcanically active; small hydrothermal vents release smoke into the caves that slowly settles like rain.

 If you can model how the smoke flows through the caves, you might be able to avoid it and be that much safer. The submarine generates a heightmap of the floor of the nearby caves for you (your puzzle input).

 Smoke flows to the lowest point of the area it's in. For example, consider the following heightmap:

 2199943210
 3987894921
 9856789892
 8767896789
 9899965678

 Each number corresponds to the height of a particular location, where 9 is the highest and 0 is the lowest a location can be.

 Your first goal is to find the low points - the locations that are lower than any of its adjacent locations. Most locations have four adjacent locations (up, down, left, and right); locations on the edge or corner of the map have three or two adjacent locations, respectively. (Diagonal locations do not count as adjacent.)

 In the above example, there are four low points, all highlighted: two are in the first row (a 1 and a 0), one is in the third row (a 5), and one is in the bottom row (also a 5). All other locations on the heightmap have some lower adjacent location, and so are not low points.

 The risk level of a low point is 1 plus its height. In the above example, the risk levels of the low points are 2, 1, 6, and 6. The sum of the risk levels of all low points in the heightmap is therefore 15.

 Find all of the low points on your heightmap. What is the sum of the risk levels of all low points on your heightmap?
 
 ### Part Two
 
 Next, you need to find the largest basins so you know what areas are most important to avoid.

 A basin is all locations that eventually flow downward to a single low point. Therefore, every low point has a basin, although some basins are very small. Locations of height 9 do not count as being in any basin, and all other locations will always be part of exactly one basin.

 The size of a basin is the number of locations within the basin, including the low point. The example above has four basins.

 The top-left basin, size 3:

 2199943210
 3987894921
 9856789892
 8767896789
 9899965678

 The top-right basin, size 9:

 2199943210
 3987894921
 9856789892
 8767896789
 9899965678

 The middle basin, size 14:

 2199943210
 3987894921
 9856789892
 8767896789
 9899965678

 The bottom-right basin, size 9:

 2199943210
 3987894921
 9856789892
 8767896789
 9899965678

 Find the three largest basins and multiply their sizes together. In the above example, this is 9 * 14 * 9 = 1134.

 What do you get if you multiply together the sizes of the three largest basins?
 */

// Get the input
let input = try String(contentsOf: "day_9_input").components(separatedBy: CharacterSet.newlines).filter{!$0.isEmpty}.map{$0.compactMap{$0.wholeNumberValue}}
let n = input.count
let m = input[0].count

// Recurse, DFS and find the basins for part 2
var seen:[[Bool]] = Array(repeating: Array(repeating: false, count: input[0].count), count: input.count)
func findBasin(row: Int, col: Int) -> Int {
    // Check for edge or already marked spot
    if ( !input.indices.contains(row) || !input[0].indices.contains(col) || input[row][col] == 9 || seen[row][col]) {
        return 0
    }
    
    // Mark as seen
    seen[row][col] = true
    
    // Dive deeper
    var basinsize = 1
    basinsize += findBasin(row: row-1, col: col)
    basinsize += findBasin(row: row+1, col: col)
    basinsize += findBasin(row: row, col: col-1)
    basinsize += findBasin(row: row, col: col+1)
    return basinsize
}

// Checks if a particular location is risky
func isRisky(row: Int, col: Int) -> Bool {
    let val = input[row][col]
    
    // Get the neighbors
    let xl = (col > 0) ? input[row][col-1] : -1
    let xr = (col < m-1) ? input[row][col+1] : -1
    let yu = (row > 0) ? input[row-1][col] : -1
    let yd = (row < n-1) ? input[row+1][col] : -1
    
    // Check if it's risky
    return ((xl == -1 || xl > val) && (xr == -1 || xr > val) && (yu == -1 || yu > val) && (yd == -1 || yd > val))
}

var answer1 = 0
var basinsizes:[Int] = Array()
for row in 0..<n {
    for col in 0..<m {
        if isRisky(row: row, col: col) {
            answer1 += input[row][col] + 1
            basinsizes.append(findBasin(row: row, col: col))
        }
    }
}
print("Part 1=\(answer1)")

let answer2 = basinsizes.sorted().reversed()[0..<3].reduce(1, *)
print("Part 2=\(answer2)")
//: [Next](@next)
