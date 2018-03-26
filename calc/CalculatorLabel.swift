import UIKit

class CalculatorLabel: UILabel {

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    textColor = .white
    backgroundColor = Color.elementBackground
    font = UIFont(name: "Menlo-Regular", size: 30)
    numberOfLines = 0
  }

}

