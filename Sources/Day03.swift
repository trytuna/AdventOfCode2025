import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  func part1() -> Any {
    let joltages = entities.map { bank in
      let batteries = bank.map { $0.wholeNumberValue! }
      let maxNumber = batteries[0..<batteries.count - 1].max()!
      let maxNumberIndex = batteries.firstIndex(of: maxNumber)!
      if(maxNumberIndex == batteries.count - 2) {
        return Int("\(batteries[maxNumberIndex])\(batteries[batteries.count - 1])")!
      }
      let nextMaxNumber = batteries[maxNumberIndex + 1...batteries.count - 1].max()!
      return Int("\(maxNumber)\(nextMaxNumber)")!
    }

    return joltages.reduce(0, +)
  }

  func part2() -> Any {
    let numberOfBatteries = 12

    let joltages = entities.map { bank in
      let batteries = bank.map { $0.wholeNumberValue! }
      let endIndex = (batteries.count - 1) - (numberOfBatteries - 1)
      let maxNumber = batteries[0...endIndex].max()!
      let maxNumberIndex = batteries.firstIndex(of: maxNumber)!
      if(maxNumberIndex == (batteries.count - 1) - (numberOfBatteries - 1)) {
        print(Int(batteries[maxNumberIndex..<batteries.count].map { String($0) }.joined())!)
        return Int(batteries[maxNumberIndex..<batteries.count].map { String($0) }.joined())!
      }

      var numbers = ""
      var nextIndex = maxNumberIndex + 1
      for nextBatteryNumber in (2...numberOfBatteries) {
        let nextMaxNumber = batteries[nextIndex...(batteries.count - 1) - (numberOfBatteries - nextBatteryNumber)].max()!
        let nextMaxNumberIndex = batteries[nextIndex...(batteries.count - 1) - (numberOfBatteries - nextBatteryNumber)].firstIndex(of: nextMaxNumber)!
        numbers = "\(numbers)\(nextMaxNumber)"
        nextIndex = nextMaxNumberIndex + 1
      }
      print("\(maxNumber)\(numbers)")
      return Int("\(maxNumber)\(numbers)")!
    }

    return joltages.reduce(0, +)
  }
}
