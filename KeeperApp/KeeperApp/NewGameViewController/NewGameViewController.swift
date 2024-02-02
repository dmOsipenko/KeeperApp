import UIKit

class NewGameViewController: BaseViewController, NewGameView  {
        
    private var tableView: DynamicHeightTableView = {
        let view = DynamicHeightTableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backColor
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var mainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start game", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 24) ?? UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.buttonColor
        button.titleLabel?.setShadow(color: UIColor.black, height: 2)
        button.setShadow(color: UIColor.gray, height: 6)
        return button
    }()
    
    var presenter: NewGamePresenterProtocol
    
    init(presenter: NewGamePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = "Game Counter"
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainButton.layer.cornerRadius = mainButton.frame.size.height / 2
    }
    
    private func setupTableView() {
        tableView.register(NewGameCell.self, forCellReuseIdentifier: NewGameCell.reuseId)
        tableView.setupDelegateData(self)
        tableView.bounces = false
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
    }
    
    @objc func tapMainButton() {
        presenter.tapMainButton()
    }
    
    override func tapLeft() {
//        presenter?.tapCancel()
    }
    
    //MARK: - NewGameView method
    func reloadData() {
        tableView.reloadData()
        mainButton.isEnabled = presenter.isCheckButtonEnable()
    }
    
    // MARK: - Navigation
    func cancel() {
        dismiss(animated: true)
    }
    
    func showAddViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMainViewController(vc: UIViewController) {
        navigationController?.setViewControllers([vc], animated: true)
    }
}


//MARK: - NewGameViewController
extension NewGameViewController {
    private func setupConstraints() {
        view.addSubview(mainButton)
        mainButton.addTarget(self, action: #selector(tapMainButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            mainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            mainButton.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 25),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension NewGameViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countPlayers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NewGameCell.self, for: indexPath)
        cell.update(player: presenter.players[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NewGameHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        return headerView
    }
    

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerViewPresenter = NewGameFooterPresenter()
        let footerView = NewGameFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100), presenter: footerViewPresenter)
        footerViewPresenter.view = footerView
        footerView.delegate = self
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

//MARK: - UITableViewDragDelegate
extension NewGameViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.changePlayerPosition(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
}

//MARK: - метод для удаления ячейки
extension NewGameViewController: DeleteCellProtocol {
    func deleteCell(indexPath: IndexPath) {
        presenter.deleteCell(indexPath: indexPath)
        tableView.reloadData()
    }
}

//MARK: - TransitionFooterViewDelegate
extension NewGameViewController: TransitionFooterViewDelegate {

    func getPlayer(player: Player) {
        presenter.addPlayers(player: player)
    }
    
    func push(vc: UIViewController) {
        presenter.tapAddButton(vc: vc)
    }
}
