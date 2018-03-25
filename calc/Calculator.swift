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

  var equationAtoms = [Atom]()

  mutating func perform(action: Action) {
    switch action {
    case let .number(x): equationAtoms.append(.value(x))
    case .add: equationAtoms.append(.additionSymbol)
    case .subtract: equationAtoms.append(.subtractionSymbol)
    case .multiply: equationAtoms.append(.multiplicationSymbol)
    case .divide: equationAtoms.append(.divisionSymbol)
    case .addDecimal: break
    case .delete: break
    }

    delegate?.equationDidUpdate(withString: stringForEquationAtoms())
  }

  func stringForEquationAtoms() -> String {
    return "foo"
  }

}
