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
    case additionSymbol
    case subtractionSymbol
    case multiplicationSymbol
    case divisionSymbol
  }

  var atoms = [Atom]()

  mutating func perform(action: Action) {
    switch action {
    case let .number(x): atoms.append(.value(x))
    case .add: atoms.append(.additionSymbol)
    case .subtract: atoms.append(.subtractionSymbol)
    case .multiply: atoms.append(.multiplicationSymbol)
    case .divide: atoms.append(.divisionSymbol)
    case .addDecimal: break
    case .delete: break
    }

    delegate?.equationDidUpdate(withString: stringForAtoms())
  }

  func stringForAtoms() -> String {
    return atoms.map { string(forAtom: $0) }
                .reduce("") { $0 + " " + $1 }
  }

  func string(forAtom atom: Atom) -> String {
    switch atom {
    case let .value(x): return String(x)
    case .additionSymbol: return "+"
    case .subtractionSymbol: return "-"
    case .multiplicationSymbol: return "×"
    case .divisionSymbol: return "÷"
    }
  }

}
