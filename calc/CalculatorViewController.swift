import UIKit

class CalculatorViewController: UIViewController {

  let viewMargin: CGFloat = 10

  let buttons = CalculatorButtonFactory.buttons()

  var addedButtons: [CalculatorButton] = []

  let resultLabel: UILabel = {
    let resultLabel = UILabel()
    resultLabel.textColor = .black
    resultLabel.translatesAutoresizingMaskIntoConstraints = false
    return resultLabel
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpResultsLabel()
    setUpButtons()
  }

  func setUpResultsLabel() {
    view.addSubview(resultLabel)
    resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: viewMargin).isActive = true
    resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewMargin).isActive = true
    resultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewMargin).isActive = true
    resultLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }

  func setUpButtons() {
    setUpButtonRow(index: 0)
    setUpButtonRow(index: 1)
    setUpButtonRow(index: 2)
    setUpButtonRow(index: 3, lastRow: true)
    constrainButtonSizes()
  }
  
  func setUpButtonRow(index: Int, lastRow: Bool = false) {
    let lastViewInPreviousRow = view.subviews.last!
    var previousViewInRow: UIView?

    let rowDigitButtons = buttons[4*index ..< 4*index+4]

    for button in rowDigitButtons {
      view.addSubview(button)
      addedButtons.append(button)

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

  func constrainButtonSizes() {
    let firstButton = buttons.first!

    for button in addedButtons {
      button.heightAnchor.constraint(equalTo: firstButton.heightAnchor).isActive = true
      button.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
    }
  }

}
