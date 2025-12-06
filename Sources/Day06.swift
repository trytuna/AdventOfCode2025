import Algorithms
import Foundation

struct Day06: AdventDay {
  var data: String

  var entities: [[String]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").map { String($0) }
    }
  }

  var entities2: [[String]] {
    data.split(separator: "\n").map {
      $0.striding(by: 1).map { String($0) }
    }
  }

  @available(macOS 15.0, *)
  func part1() -> Any {
    var transposed: [[String]] = []
    for (rowIndex, row) in entities.enumerated() {
      for (columnIndex, column) in row.enumerated() {
        if transposed.indices.contains(columnIndex) {
          if !transposed[columnIndex].indices.contains(rowIndex) {
            transposed[columnIndex].append(column)
          }
        } else {
          transposed.append([column])
        }
      }
    }
    var calculatedValues: [Int] = []
    for numbers in transposed {
      let calculated = numbers[0..<numbers.count - 1].reduce(0, { result, e in
        let calcOperator = numbers[numbers.count - 1]
        if calcOperator == "+" {
          return result + Int(e)!
        } else if calcOperator == "*" {
          return (result == 0 ? 1 : result) * Int(e)!
        }
        return result
      })
      calculatedValues.append(calculated)
    }
    return calculatedValues.reduce(0, +)
  }

  func part2() -> Any {
    var transposed: [[String]] = []
    for (rowIndex, row) in entities2.enumerated() {
      for (columnIndex, column) in row.enumerated() {
        if transposed.indices.contains(columnIndex) {
          if !transposed[columnIndex].indices.contains(rowIndex) {
            transposed[columnIndex].append(column)
          }
        } else {
          transposed.append([column])
        }
      }
    }

    var calculatedValues: [Int] = []
    var accumulated: [Int] = []
    for t in transposed.reversed() {
      var stringValue = t.joined()
      stringValue.trim(while: \.isWhitespace)
      if stringValue.last == "+" {
        stringValue = String(stringValue.prefix(stringValue.count - 1))
        stringValue.trim(while: \.isWhitespace)
        accumulated.append(Int(stringValue)!)
        calculatedValues.append(accumulated.reduce(0, +))
        accumulated = []
        print("Did + calculation \(calculatedValues)")
        continue
      } else if stringValue.last == "*" {
        stringValue = String(stringValue.prefix(stringValue.count - 1))
        stringValue.trim(while: \.isWhitespace)
        accumulated.append(Int(stringValue)!)
        calculatedValues.append(accumulated.reduce(0, { result, e in
          (result == 0 ? 1 : result) * e
        }))
        accumulated = []
        print("Did * calculation \(calculatedValues)")
        continue
      }
      if !stringValue.isEmpty {
        accumulated.append(Int(stringValue)!)
      }
      print("\(stringValue) added\n")
    }
    
    return calculatedValues.reduce(0, +)
  }
}
