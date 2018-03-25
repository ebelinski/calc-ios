import UIKit

class CalculatorButton: UIButton {

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = Color.grayBackground
  }

}
