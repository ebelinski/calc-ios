import Foundation

protocol CalculatorDelegate: class {
  func equationDidUpdate(withString string: String)
}

enum CalculatorError: Error {
  case divideByZero
}

struct Calculator {

  weak var delegate: CalculatorDelegate?

  enum Action {
    case number(Int)
    case add
    case subtract
    case multiply
    case divide
    case addDecimal
    case delete
  }

  enum Atom {
    case value(Int)
    case symbol(Symbol)
  }

  enum Symbol {
    case addition
    case subtraction
    case multiplication
    case division
  }

  var atoms = [Atom]()

  mutating func perform(action: Action) {
    switch action {
    case let .number(x): process(value: x)
    case .add: process(symbol: .addition)
    case .subtract: process(symbol: .subtraction)
    case .multiply: process(symbol: .multiplication)
    case .divide: process(symbol: .division)
    case .addDecimal: break
    case .delete: processDeleteAction()
    }

    delegate?.equationDidUpdate(withString: stringForAtoms())
  }

  mutating func process(value: Int) {
    if let lastAtom = atoms.last {
      switch lastAtom {
      case let .value(x):
        atoms[atoms.count-1] = .value(x * 10 + value)
        return
      case .symbol(_): break
      }
    }
    atoms.append(.value(value))
  }

  mutating func process(symbol: Symbol) {
    if atoms.isEmpty { return }
    if let lastAtom = atoms.last {
      switch lastAtom {
      case .value(_): break
      case .symbol(_): return
      }
    }
    atoms.append(.symbol(symbol))
  }

  mutating func processDeleteAction() {
    guard let last = atoms.last else { return }
    switch last {
    case let .value(x):
      if x < 10 {
        atoms.removeLast()
      } else {
        atoms[atoms.count-1] = .value((x - (x % 10)) / 10)
      }
    case .symbol(_): atoms.removeLast()
    }
  }

  func stringForAtoms() -> String {
    let equationString = atoms.map { string(forAtom: $0) }
                              .reduce("") { $0 + " " + $1 }
                              .trimmingCharacters(in: .whitespaces)

    return "\(equationString) \n\n= \(processEquation())"
  }

  func string(forAtom atom: Atom) -> String {
    switch atom {
    case let .value(x): return String(x)
    case .symbol(.addition): return "+"
    case .symbol(.subtraction): return "-"
    case .symbol(.multiplication): return "×"
    case .symbol(.division): return "÷"
    }
  }

  func processEquation() -> String {
    do {
      return try String(processCleanup(atoms: atoms))
    } catch CalculatorError.divideByZero {
      return "divide by zero error"
    } catch {
      return "unknown error"
    }
//    return String(processCleanup(atoms: atoms))
  }

  func processCleanup(atoms: [Atom]) throws -> Int {
    if let last = atoms.last {
      switch last {
      case .value(_): return try processMultiplicationAndDivision(atoms: atoms)
      case .symbol(_): return try processCleanup(atoms: Array(atoms.dropLast()))
      }
    }

    return 0 // no atoms
  }

  func processMultiplicationAndDivision(atoms: [Atom]) throws -> Int {
    if atoms.isEmpty { return 0 }
    if atoms.count == 1 {
      switch atoms[0] {
      case let .value(x): return x
      case .symbol(_): fatalError("Unexpected symbol")
      }
    }

    let tuple = (atoms[0], atoms[1], atoms[2], Array(atoms.dropFirst(3)))

    switch tuple {
    case let (.value(l), .symbol(.multiplication), .value(r), remainder):
      return try processMultiplicationAndDivision(atoms: [.value(l * r)] + remainder)
    case let (.value(l), .symbol(.division), .value(r), remainder):
      if r == 0 { throw CalculatorError.divideByZero }
      return try processMultiplicationAndDivision(atoms: [.value(l / r)] + remainder)
    default:
      let prefix: [Atom] = Array(atoms.prefix(2))
      let remainder: [Atom] = [.value(try processMultiplicationAndDivision(atoms: Array(atoms.dropFirst(2))))]
      return processAdditionAndSubtraction(atoms: prefix + remainder)
    }
  }

  func processAdditionAndSubtraction(atoms: [Atom]) -> Int {
    if atoms.isEmpty { return 0 }
    if atoms.count == 1 {
      switch atoms[0] {
      case let .value(x): return x
      case .symbol(_): fatalError("Unexpected symbol")
      }
    }

    let tuple = (atoms[0], atoms[1], atoms[2], Array(atoms.dropFirst(3)))

    switch tuple {
    case let (.value(l), .symbol(.addition), .value(r), remainder):
      return processAdditionAndSubtraction(atoms: [.value(l + r)] + remainder)
    case let (.value(l), .symbol(.subtraction), .value(r), remainder):
      return processAdditionAndSubtraction(atoms: [.value(l - r)] + remainder)
    default: fatalError("Unexpected tuple value: \(tuple)")
    }
  }

}
