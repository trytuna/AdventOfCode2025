import Algorithms

struct Day05: AdventDay {
  var data: String

  var entities: [[String]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { String($0) }
    }    
  }

  func part1() -> Any {
    let ranges = entities[0].map { $0.split(separator: "-") }.map { (Int($0[0])!...Int($0[1])!) }

    var freshIngridients: [Int] = []
    entities[1].forEach { ingridient in
      ranges.forEach { range in
        if range.contains(Int(ingridient)!) && !freshIngridients.contains(Int(ingridient)!) {
          freshIngridients.append(Int(ingridient)!)
        }
      }
    }

    return freshIngridients.count
  }

  func part2() -> Any {
    let ranges: [ClosedRange<Int>] = entities[0].map { $0.split(separator: "-") }.map { (Int($0[0])!...Int($0[1])!) }
    let mergedRanges: [ClosedRange<Int>] = ranges.merge(with: ranges)

    return mergedRanges.map { $0.distance(from: $0.startIndex, to: $0.endIndex) }.reduce(0, +)
  }
}

extension Array where Element == ClosedRange<Int> {
  func overlaps(with other: [ClosedRange<Int>]) -> Bool {
    for range in self {
      for otherRange in other {
        if range.overlaps(otherRange) {
          return true
        }
      }
    }
    return false
  }

  func merge(with other: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
    let allRanges = (self + other).sorted { $0.lowerBound < $1.lowerBound }
    
    guard var current = allRanges.first else { return [] }
    var result: [ClosedRange<Int>] = []
    
    for range in allRanges.dropFirst() {
        if current.overlaps(range) || current.upperBound + 1 == range.lowerBound {
            current = current.lowerBound...Swift.max(current.upperBound, range.upperBound)
        } else {
            result.append(current)
            current = range
        }
    }
    result.append(current)
    
    return result
  }
}
