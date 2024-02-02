import UIKit

protocol TransitionFooterViewDelegate: AnyObject {
    func push(vc: UIViewController)
    func getPlayer(player: Player)
}


class NewGameFooterView: UIView, FooterView {
    
    private var footerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.buttonColor
        label.font = UIFont(name: "Nunito-Bold", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Add player"
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Add"), for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: TransitionFooterViewDelegate?
    var presenter: NewGameFooterPresenterProtocol
    
     init(frame: CGRect, presenter: NewGameFooterPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: frame)
        self.backgroundColor = UIColor.backColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAddButton() {
        presenter.tapAddButton()
    }
    
    //MARK: - FooterView method
    
    func showAddViewController(vc: UIViewController) {
        delegate?.push(vc: vc)
    }
    
    func player(player: Player) {
        delegate?.getPlayer(player: player)
    }
}

extension NewGameFooterView {
    private func setupConstraints() {
        setupAddButton()
        setupfooterTitle()
    }
    
    private func setupAddButton() {
        self.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            addButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            addButton.heightAnchor.constraint(equalToConstant: 25),
            addButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupfooterTitle() {
        self.addSubview(footerTitle)
        NSLayoutConstraint.activate([
            footerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            footerTitle.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 10),
            footerTitle.heightAnchor.constraint(equalToConstant: 25),
            footerTitle.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
