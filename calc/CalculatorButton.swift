import UIKit

class CalculatorButton: UIButton {

  enum Action {
    case number(Int)
    case add
    case subtract
    case multiply
    case divide
    case addDecimal
    case delete
  }

  let action: Action

  init(withAction action: Action) {
    self.action = action

    super.init(frame: .zero)

    var title: String?
    switch action {
    case let .number(x): title = String(x)
    case .add: title = "+"
    case .subtract: title = "-"
    case .multiply: title = "×"
    case .divide: title = "÷"
    case .addDecimal: title = "."
    case .delete: title = "<"
    }
    setTitle(title, for: .normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    setTitleColor(.blue, for: .normal)
    backgroundColor = Color.grayBackground
    titleLabel?.font = UIFont.systemFont(ofSize: 30)
  }

}
