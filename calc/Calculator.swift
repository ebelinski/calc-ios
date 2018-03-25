import Foundation

protocol CalculatorDelegate {
  func equationDidUpdate(withString string: String)
}

struct Calculator {

  var delegate: CalculatorDelegate?

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
    case .delete: removeLastAtom()
    }

    delegate?.equationDidUpdate(withString: stringForAtoms())
  }

  mutating func process(value: Int) {
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

  mutating func removeLastAtom() {
    if atoms.isEmpty { return }
    atoms.removeLast()
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
    return String(processCleanup(atoms: atoms))
  }

  func processCleanup(atoms: [Atom]) -> Int {
    if let last = atoms.last {
      switch last {
      case .value(_): return processMultiplicationAndDivision(atoms: atoms)
      case .symbol(_): return processCleanup(atoms: Array(atoms.dropLast()))
      }
    }

    return 0 // no atoms
  }

  func processMultiplicationAndDivision(atoms: [Atom]) -> Int {
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
      return processMultiplicationAndDivision(atoms: [.value(l * r)] + remainder)
    case let (.value(l), .symbol(.division), .value(r), remainder):
      return processMultiplicationAndDivision(atoms: [.value(l / r)] + remainder)
    default: return processAdditionAndSubtraction(atoms: atoms)
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
    default: fatalError("Unexpected tuple value")
    }
  }

}
