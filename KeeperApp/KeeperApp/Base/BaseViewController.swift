import UIKit

class BaseViewController: UIViewController {
    
    var titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-Bold", size: 36)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "New Game"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
    }
    
     func setupLeftItem(title: String) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(tapLeft))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Nunito-Bold", size: 17)!], for: UIControl.State.normal)
    }
    
     func setupRightItem(title: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(tapRight))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Nunito-Bold", size: 17)!], for: UIControl.State.normal)
    }
    
    @objc func tapLeft() { }
    
    @objc func tapRight() {}
}

extension BaseViewController {
    private func setupConstraints() {
        view.addSubview(titleText)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: margins.topAnchor, constant: 12),
            titleText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            titleText.heightAnchor.constraint(equalToConstant: 43)
        ])
    }
}
