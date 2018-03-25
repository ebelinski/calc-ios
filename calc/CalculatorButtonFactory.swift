import Foundation

struct CalculatorButtonFactory {

  static func digitButtons() -> [CalculatorButton] {
    var buttons: [CalculatorButton] = []

    for i in 0..<10 {
      let button = CalculatorButton()
      button.setTitle(String(9-i), for: .normal)
      button.tag = 9-i
      buttons.append(button)
    }

    return buttons
  }

}
