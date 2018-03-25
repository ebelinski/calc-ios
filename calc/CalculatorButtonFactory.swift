import Foundation

struct CalculatorButtonFactory {

  static func buttons() -> [CalculatorButton] {
    let actions: [CalculatorButton.Action] = [
      .number(9), .number(8), .number(7), .divide,
      .number(6), .number(5), .number(4), .multiply,
      .number(3), .number(2), .number(1), .subtract,
      .number(0), .addDecimal, .delete, .add
    ]

    return actions.map { CalculatorButton(withAction: $0) }
  }

}
