import UIKit

class CalculatorViewController: UIViewController {

  let addButton: UIButton = {
    let addButton = UIButton()
    addButton.translatesAutoresizingMaskIntoConstraints = false
    addButton.setTitle("+", for: .normal)
    addButton.setTitleColor(.blue, for: .normal)
    addButton.addTarget(self,
                        action: #selector(CalculatorViewController.didPressAddButton),
                        for: .touchUpInside)
    return addButton
  }()

  let resultLabel: UILabel = {
    let resultLabel = UILabel()
    resultLabel.textColor = .black
    resultLabel.translatesAutoresizingMaskIntoConstraints = false
    return resultLabel
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(addButton)
    addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    view.addSubview(resultLabel)
    resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    resultLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor).isActive = true
  }

  @objc func didPressAddButton() {
    let result = Calculator.add(2, 3)
    resultLabel.text = String(result)
  }

}
