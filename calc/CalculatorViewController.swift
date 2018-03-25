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

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(addButton)
    addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  @objc func didPressAddButton() {
    print("Pressed add button")
  }

}
