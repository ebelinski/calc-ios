import UIKit

class CalculatorButton: UIButton {

  init(withValue value: String) {
    super.init(frame: .zero)

    setTitle(value, for: .normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    translatesAutoresizingMaskIntoConstraints = false
    setTitleColor(.blue, for: .normal)
    backgroundColor = Color.grayBackground
  }

}
