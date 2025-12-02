import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").map {
      return String($0).split(separator: ",").map {
        return String($0)
      }
    }.reduce([], +)
  }

  func part1() -> Int {
    let invalidIDs: [Int] = entities.map {
      let range: [Int] = $0.split(separator: "-").map { Int($0)! }
      let invalidIDsInRange = (range.first!...range.last!).filter {
        if $0.description.count % 2 == 0 {
          if $0.description.prefix($0.description.count / 2) == $0.description.suffix($0.description.count / 2) {
            if $0.description.prefix(1) == "0" {
              print($0.description)
            }
            return true
          }
        }
        return false
      }
      return invalidIDsInRange
    }.reduce([], +)

    return invalidIDs.reduce(0, { a, b in
      a + b
    })
  }

  func part2() -> Int {
    let invalidIDs: [Int] = entities.map {
      let range: [Int] = $0.split(separator: "-").map { Int($0)! }
      let invalidIDsInRange = (range.first!...range.last!).filter { number in
        let stringArray = number.description.map { String($0) }
          if stringArray.count == 1 {
            print("\(stringArray) too short")
            return false
          }
          if number.description.count % 2 != 0 {
            let allSame = stringArray.reduce(true, { x, y in
              stringArray[0] == y && x
            })
            if allSame {
              print("\(number.description) => \(allSame)")
              return true
            }
          }
          let chunkedArrays = stringArray.evenChunkRanges().map { ranges in
            return ranges.map { chunkRange in
              return String(stringArray[chunkRange].joined(separator: ""))
            }
          }

          for chunckedArray in chunkedArrays {
            let allChunksSame = chunckedArray.reduce(true, { result, chunk in
              return chunckedArray[0] == chunk && result
            })
            if allChunksSame {
              print("\(number.description) => \(chunckedArray) => \(allChunksSame)")
              return true
            }
          }

          let allSame = stringArray.reduce(true, { x, y in
            stringArray[0] == y && x
          })
          if allSame {
            print("\(number.description) => \(allSame)")
            return true
          }

          return false
      }
      return invalidIDsInRange
    }.reduce([], +)

    return invalidIDs.reduce(0, { a, b in
      a + b
    })
  }
}

extension Array {
  func evenChunks() -> [Int] {
    if self.count <= 3 {
      return [1]
    }
    return (2...(self.count <= 3 ? self.count : self.count / 2)).filter { self.count % $0 == 0 }
  }

  func evenChunkRanges() -> [[Range<Int>]] {
    return self.evenChunks().map { chunkSize in
      return (0..<self.count / chunkSize).map { chunkNumber in
        return (chunkNumber*chunkSize..<(chunkNumber+1) * chunkSize)
      }
    }
  }
}
