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
    return atoms.map { string(forAtom: $0) }
                .reduce("") { $0 + " " + $1 }
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

}
