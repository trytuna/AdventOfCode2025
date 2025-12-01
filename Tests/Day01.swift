import Testing

@testable import AdventOfCode

struct Day01Tests {
  let testData = """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """
  //  L132
  //   R200
  @Test func parseRotation() async throws {
    #expect(Rotation.left(1).rawValue == "L1")
    #expect(Rotation.right(100).rawValue == "R100")
    #expect(Rotation.init(rawValue: "R1")! == Rotation.right(1))
    #expect(Rotation.init(rawValue: "L100")! == Rotation.left(100))
  }
  
  @Test func testLeftRotation() async throws {
    let safe = Safe()
    await safe.rotate(rotation: Rotation.left(1))
    #expect(await safe.currentPosition == 49)

    await safe.rotate(rotation: Rotation.left(49))
    #expect(await safe.currentPosition == 0)

    await safe.rotate(rotation: Rotation.left(1))
    #expect(await safe.currentPosition == 99)

    await safe.rotate(rotation: Rotation.left(1001))
    #expect(await safe.currentPosition == 98)

    #expect(await safe.password == 1)
  }

  @Test func testRightRotation() async throws {
    let safe = Safe()
    await safe.rotate(rotation: Rotation.right(1))
    #expect(await safe.currentPosition == 51)

    await safe.rotate(rotation: Rotation.right(49))
    #expect(await safe.currentPosition == 0)

    await safe.rotate(rotation: Rotation.right(1))
    #expect(await safe.currentPosition == 1)

    await safe.rotate(rotation: Rotation.right(1001))
    #expect(await safe.currentPosition == 2)

    #expect(await safe.password == 1)
  }

  @Test func testPart1() async throws {
    let challenge = Day01(data: testData)
    let password = try await challenge.part1()
    #expect(password == 3, "Password: \(password)")
  }

  @Test func testPart2() async throws {
    let challenge = Day01(data: testData)
    let password = try await challenge.part2()
    #expect(password == 6, "Password: \(password)")
  }
}
