import UIKit

class AddPlayerViewController: BaseViewController, AddPlayerView {
    
   private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backColor
        return view
    }()
    
    private let nameTextField: UITextField = {
        let fild = UITextField()
        fild.borderStyle = .none
        fild.textColor = .gray
        fild.font = UIFont(name: "Nunito-Bold", size: 20)
        fild.translatesAutoresizingMaskIntoConstraints = false
        fild.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        fild.becomeFirstResponder()
        return fild
    }()
    
    var presenter: AddPlayerPresenterProtocol
    var addBlock: ((Player) -> Void)?
    
    
    init(presenter: AddPlayerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupUI()
    }
    
    override func tapLeft() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tapRight() {
        guard let name = nameTextField.text else {return}
        let player = Player(name: name, points: 0)
        presenter.addPlayer(player: player)
    }
    
    private func setupUI() {
        setupLeftItem(title: "Back")
        setupRightItem(title: "Add")
        titleText.text = "Add  Player"
        navigationItem.rightBarButtonItem?.isEnabled = false
        nameTextField.delegate = self
    }
    
    //MARK: - NewGameView method
    func savePlayer(player: Player) {
        addBlock?(player)
        navigationController?.popViewController(animated: true)
    }
    
    func checkButton(isEnable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isEnable
    }
}

    //MARK: - set constraints
extension AddPlayerViewController {
    private func setupConstraints() {
        view.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 25),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        backView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 24),
            nameTextField.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -24),
            nameTextField.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension AddPlayerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.checkAddButton(text: textField.text ?? "")
    }
}
