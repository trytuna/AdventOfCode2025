import Algorithms
import Foundation

enum PasswordMethod {
  case standard
  case x434C49434B
}

actor Safe {
  var currentPosition = 50
  var password = 0

  public func rotate(rotation: Rotation, passwordMethod: PasswordMethod = .standard) {
    switch rotation {
      case .left(let amount):
        let (currentPosition, password) = leftRotation(amount: amount, passwordMethod: passwordMethod)
        self.currentPosition = currentPosition
        self.password += password
        return
      case .right(let amount):
        let (currentPosition, password) = rightRotation(amount: amount, passwordMethod: passwordMethod)
        self.currentPosition = currentPosition
        self.password += password
        return
    }
  }

  private func leftRotation(amount: Int, passwordMethod: PasswordMethod = .standard) -> (Int, Int) {
    var newAmount = amount
    var passwordIncrements = 0
    if(amount >= 100) {
      newAmount = amount % 100
      passwordIncrements = (amount - newAmount) / 100
    }

    switch passwordMethod {
      case .standard:
        if((currentPosition - newAmount) < 0) {
          let newPosition = 100 - (newAmount - currentPosition)
          return (newPosition, newPosition == 0 ? 1 : 0)
        }

        return (currentPosition - newAmount, (currentPosition - newAmount) == 0 ? 1 : 0)
      case .x434C49434B:
        if((currentPosition - newAmount) < 0) {
          let newPosition = 100 - (newAmount - currentPosition)
          passwordIncrements += currentPosition != 0 ? 1 : 0
          return (newPosition, passwordIncrements)
        }

        return (currentPosition - newAmount, (currentPosition - newAmount) == 0 ? passwordIncrements + 1 : passwordIncrements)
    }
  }

  private func rightRotation(amount: Int, passwordMethod: PasswordMethod = .standard) -> (Int, Int) {
    var newAmount = amount
    var passwordIncrements = 0
    
    if(amount >= 100) {
      newAmount = amount % 100
      passwordIncrements = (amount - newAmount) / 100
    }

    switch passwordMethod {
      case .standard:
        if(currentPosition + newAmount > 99) {
          let newPosition = (currentPosition + newAmount) - 100
          return (newPosition, newPosition == 0 ? 1 : 0)
        }
        return (currentPosition + newAmount, (currentPosition + newAmount) == 0 ? 1 : 0) 
      case .x434C49434B:
        if(currentPosition + newAmount > 99) {
          let newPosition = (currentPosition + newAmount) - 100
          passwordIncrements += currentPosition != 0 ? 1 : 0
          return (newPosition, passwordIncrements)
        }
        return (currentPosition + newAmount, (currentPosition + newAmount) == 0 ? passwordIncrements + 1 : passwordIncrements)
    }
  }
}

enum Rotation {
  case left(Int)
  case right(Int)
}

extension Rotation: RawRepresentable {
  enum RotationError: Error {
    case unknown(String)
  }

  init?(rawValue: String) {
    let prefix = rawValue.prefix(1)
    let stringAmount = rawValue.suffix(from: rawValue.index(rawValue.startIndex, offsetBy: 1))
    guard let amount = Int(stringAmount) else {
      return nil
    }

    switch prefix.uppercased() {
      case "L":
        self = .left(amount)
      case "R":
        self = .right(amount)
      default:
        return nil
    }
  }

  var rawValue: String {
    switch self {
      case .left(let amount):
        return "L\(amount)"
      case .right(let amount):
        return "R\(amount)"
    }
  }

  typealias RawValue = String
}

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.components(separatedBy: "\n")
  }

  func part1() async throws -> Int {
    let safe = Safe()

    for var entry in entities {
      guard let rotation = Rotation.init(rawValue: entry) else {
        throw Rotation.RotationError.unknown("\(entry) not parsable")
      }
      
      await safe.rotate(rotation: rotation)
      print("\(rotation) -> \(await safe.currentPosition) -> password \(await safe.password)")
    }

    return await safe.password
  }

  func part2() async throws -> Int {
    let safe = Safe()

    for var entry in entities {
      guard let rotation = Rotation.init(rawValue: entry) else {
        throw Rotation.RotationError.unknown("\(entry) not parsable")
      }
      
      await safe.rotate(rotation: rotation, passwordMethod: .x434C49434B)
      print("\(rotation) -> \(await safe.currentPosition) -> password \(await safe.password)")
    }

    return await safe.password
  }
}
