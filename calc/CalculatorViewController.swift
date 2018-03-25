import UIKit

class CalculatorViewController: UIViewController {

  let calculator = Calculator()

  let viewMargin: CGFloat = 10

  let buttons = CalculatorButtonFactory.buttons()

  let screenLabel: UILabel = {
    let screenLabel = UILabel()
    screenLabel.textColor = .black
    screenLabel.translatesAutoresizingMaskIntoConstraints = false
    return screenLabel
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpScreenLabel()
    setUpButtons()
  }

  func setUpScreenLabel() {
    view.addSubview(screenLabel)
    screenLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: viewMargin).isActive = true
    screenLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewMargin).isActive = true
    screenLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewMargin).isActive = true
    screenLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
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

    for button in buttons {
      button.heightAnchor.constraint(equalTo: firstButton.heightAnchor).isActive = true
      button.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
    }
  }

  @objc func didPress(calculatorButton button: CalculatorButton) {
    print("Pressed button with action \(button.action)")
  }

}
