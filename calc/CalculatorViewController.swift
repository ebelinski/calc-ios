import UIKit

class CalculatorViewController: UIViewController {

  let digitButtons = CalculatorButtonFactory.digitButtons()
  let operatorButtons = CalculatorButtonFactory.operatorButtons()

  let resultLabel: UILabel = {
    let resultLabel = UILabel()
    resultLabel.textColor = .black
    resultLabel.translatesAutoresizingMaskIntoConstraints = false
    return resultLabel
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
