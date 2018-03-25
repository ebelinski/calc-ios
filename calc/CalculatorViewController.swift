import UIKit

class CalculatorViewController: UIViewController {

  var calculator = Calculator()

  let viewMargin: CGFloat = 10

  let buttons = CalculatorButtonFactory.buttons()

  let inputLabel = CalculatorLabel()
  let outputLabel = CalculatorLabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpLabels()
    setUpButtons()
    calculator.delegate = self
  }

  func setUpLabels() {
    view.addSubview(inputLabel)
    inputLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: viewMargin).isActive = true
    inputLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewMargin).isActive = true
    inputLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewMargin).isActive = true

    view.addSubview(outputLabel)
    outputLabel.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: viewMargin).isActive = true
    outputLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewMargin).isActive = true
    outputLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewMargin).isActive = true

    inputLabel.heightAnchor.constraint(equalTo: outputLabel.heightAnchor).isActive = true
  }

  func setUpButtons() {
    setUpButtonRow(index: 0)
    setUpButtonRow(index: 1)
    setUpButtonRow(index: 2)
    setUpButtonRow(index: 3, lastRow: true)
    setButtonActions()
    constrainButtonSizes()
  }
  
  func setUpButtonRow(index: Int, lastRow: Bool = false) {
    let lastViewInPreviousRow = view.subviews.last!
    var previousViewInRow: UIView?

    let rowDigitButtons = buttons[4*index ..< 4*index+4]

    for button in rowDigitButtons {
      view.addSubview(button)

      button.topAnchor.constraint(equalTo: lastViewInPreviousRow.bottomAnchor, constant: viewMargin).isActive = true

      if let previousViewInRow = previousViewInRow {
        button.leftAnchor.constraint(equalTo: previousViewInRow.rightAnchor, constant: viewMargin).isActive = true
      } else {
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewMargin).isActive = true
      }

      if lastRow {
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewMargin).isActive = true
      }

      previousViewInRow = button
    }

    previousViewInRow!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewMargin).isActive = true
  }

  func setButtonActions() {
    buttons.forEach { $0.addTarget(self,
                                   action: #selector(didPress(calculatorButton:)),
                                   for: .touchUpInside) }
  }

  func constrainButtonSizes() {
    let firstButton = buttons.first!
    buttons.forEach {
      $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
      $0.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
    }
  }

  @objc func didPress(calculatorButton button: CalculatorButton) {
    calculator.perform(action: button.action)
  }

}

extension CalculatorViewController: CalculatorDelegate {

  func equationDidUpdate(withInputString inputString: String,
                         andOutputString outputString: String) {
    inputLabel.text = inputString
    outputLabel.text = outputString
  }

}
