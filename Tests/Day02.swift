import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day02Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    """

  @Test func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part1() == 1227775554)
  }


  @Test func testEvenChunks() async throws {
    #expect(Array(arrayLiteral: "1", "2", "3", "4", "5", "6", "7", "8", "9", "0").evenChunks() == [2, 5])
    #expect(Array(arrayLiteral: "1", "1").evenChunks() == [1])
    #expect(Array(arrayLiteral: "1", "2").evenChunks() == [1])
    #expect(Array(arrayLiteral: "1", "1", "1").evenChunks() == [1])
    #expect("824824824".map { String($0) }.evenChunks() == [3])
  }

  @Test func testRanges() async throws {
    // let stringArray = "1234567890".map { String($0) }
    // #expect(stringArray.evenChunkRanges() == [[(0..<2), (2..<4), (4..<6), (6..<8), (8..<10)],[(0..<5), (5..<10)]])

    // let chunked = stringArray.evenChunkRanges().map { ranges in
    //   return ranges.map { range in
    //     return String(stringArray[range].joined(separator: ""))
    //   }
    // }
    // #expect(chunked == [["12", "34", "56", "78", "90"], ["12345", "67890"]])

    let shortStringArray = "12".map { String($0) }
    #expect(shortStringArray.evenChunkRanges() == [[(0..<1), (1..<2)]])

    let weird = "824824824".map { String($0) }
    #expect(weird.evenChunkRanges() == [[(0..<3), (3..<6), (6..<9)]])
  }

  @Test func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part2() == 4174379265)
  }
}
