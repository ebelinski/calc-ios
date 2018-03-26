import UIKit

class CalculatorButton: UIButton {

  let action: Calculator.Action

  init(withAction action: Calculator.Action) {
    self.action = action

    super.init(frame: .zero)

    var title: String?
    var color: UIColor?

    switch action {
    case let .number(x): title = String(x)
    case .add: title = "+"
    case .subtract: title = "-"
    case .multiply: title = "×"
    case .divide: title = "÷"
    case .addDecimal: title = "."
    case .delete: title = "<"
    }

    switch action {
    case .number(_): color = FontColor.digit
    case .add, .subtract, .multiply, .divide: color = FontColor.operation
    case .addDecimal: color = FontColor.digit
    case .delete: color = FontColor.delete
    }

    setTitle(title, for: .normal)
    setTitleColor(color, for: .normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = BackgroundColor.element
    titleLabel?.font = UIFont(name: "Menlo-Regular", size: 30)
  }

}
