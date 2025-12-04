import Algorithms

struct Day04: AdventDay {
  var data: String

  var entities: [[String]] {
    data.split(separator: "\n").map {
      $0.map { String($0) }
    }
  }

  func moveRolls(rollsMap: [[String]]) -> [[String]] {
    return rollsMap.enumerated().map { rowIndex, row in
      row.enumerated().map { columnIndex, element in
        // print("checking [\(rowIndex)][\(columnIndex)] => \(rollsMap[rowIndex][columnIndex])")
        var occurences = 0
        if rollsMap[rowIndex][columnIndex] == "@" {
          (rowIndex - 1...rowIndex + 1).forEach { r in
            if (0...rollsMap.count - 1).contains(r) {
              (columnIndex - 1...columnIndex + 1).forEach { c in
                if (0...row.count - 1).contains(c) {
                  // print("[\(r)][\(c)] => \(rollsMap[r][c])")
                  if rollsMap[r][c] == "@" {
                    occurences += 1
                  }
                }
              }
            }
          }

          // print("=> \(occurences)")
          if occurences <= 4 {
            return "x"
          }
        }
        
        return element
      }
  }
  }

  func part1() -> Any {
    let newRollsMap = moveRolls(rollsMap: entities)
    return newRollsMap.reduce([], +).filter { $0 == "x" }.count
  }

  func part2() -> Any {
    var movedRolls = 0
    var newRollsMap = entities
    var justMoved = 0
    repeat {
      newRollsMap = moveRolls(rollsMap: newRollsMap)
      justMoved = newRollsMap.reduce([], +).filter { $0 == "x" }.count
      print("\(justMoved) just moved")
      newRollsMap = newRollsMap.map {
        $0.map {
          if $0 == "x" {
            return "."
          }
          return $0
        }
      }
      movedRolls += justMoved
    } while (justMoved != 0)
    return movedRolls
  }
}
