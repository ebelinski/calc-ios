import Foundation

struct CalculatorButtonFactory {

  static func digitButtons() -> [CalculatorButton] {
    var buttons: [CalculatorButton] = []

    for i in 0..<10 {
      let button = CalculatorButton(withValue: String(9-i))
      button.tag = 9-i
      buttons.append(button)
    }

    return buttons
  }

  static func operatorButtons() -> [CalculatorButton] {
    return [
      CalculatorButton(withValue: "÷"),
      CalculatorButton(withValue: "×"),
      CalculatorButton(withValue: "-"),
      CalculatorButton(withValue: "+")
    ]
  }

  static func buttons() -> [CalculatorButton] {
    let digitButtons = CalculatorButtonFactory.digitButtons()
    let operatorButtons = CalculatorButtonFactory.operatorButtons()

    return digitButtons + operatorButtons + [CalculatorButton(withValue: ".")]
  }

}
