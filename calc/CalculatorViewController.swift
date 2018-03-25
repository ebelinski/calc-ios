import UIKit

class CalculatorViewController: UIViewController {

  let viewMargin: CGFloat = 10

  let buttons = CalculatorButtonFactory.buttons()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpButtonRow(index: 0)
    setUpButtonRow(index: 1)
    setUpButtonRow(index: 2)
    setUpButtonRow(index: 3)
  }
  
  func setUpButtonRow(index: Int) {
    let rowDigitButtons = buttons[3*index ..< 3*index+3]
    print(rowDigitButtons)
  }

}
