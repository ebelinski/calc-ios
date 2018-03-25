import Foundation

struct CalculatorButtonFactory {

  static func buttons() -> [CalculatorButton] {
    return [
      CalculatorButton(withAction: .number(9)),
      CalculatorButton(withAction: .number(8)),
      CalculatorButton(withAction: .number(7)),
      CalculatorButton(withAction: .divide),
      CalculatorButton(withAction: .number(6)),
      CalculatorButton(withAction: .number(5)),
      CalculatorButton(withAction: .number(4)),
      CalculatorButton(withAction: .multiply),
      CalculatorButton(withAction: .number(3)),
      CalculatorButton(withAction: .number(2)),
      CalculatorButton(withAction: .number(1)),
      CalculatorButton(withAction: .subtract),
      CalculatorButton(withAction: .number(0)),
      CalculatorButton(withAction: .addDecimal),
      CalculatorButton(withAction: .delete),
      CalculatorButton(withAction: .add),
    ]
  }

}
