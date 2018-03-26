import UIKit

class CalculatorLabel: UILabel {

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    textColor = .black
    backgroundColor = Color.elementBackground
    font = UIFont.systemFont(ofSize: 30)
    numberOfLines = 0
  }

}

