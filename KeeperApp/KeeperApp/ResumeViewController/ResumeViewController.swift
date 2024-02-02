import UIKit

class ResumeViewController: BaseViewController, ResumeView {
    
   lazy var resultView: ResultView = {
        let view = ResultView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backColor
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.layer.cornerRadius = 15
        view.separatorStyle = .none
        return view
    }()
    
    var presenter: ResumePresenterProtocol
    
    init(presenter: ResumePresenterProtocol) {
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
        setupTableView() 
    }
    
    private func setupUI() {
        titleText.text = "Results"
        setupLeftItem(title: "New Game")
        setupRightItem(title: "Resume")
        resultView.players = presenter.players
    }
    
    private func setupTableView() {
        tableView.register(AllPointsCell.self, forCellReuseIdentifier: AllPointsCell.reuseId)
        tableView.setupDelegateData(self)
        tableView.bounces = false
    }
    
    override func tapRight() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tapLeft() {
        presenter.tapNewGameButton()
    }
}


extension ResumeViewController {
    private func setupConstraints() {
        view.addSubview(resultView)
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            resultView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
        ])
    }
    
    //MARK: - ResumeView
    func presentNewGame(vc: UIViewController) {
        navigationController?.present(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ResumeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.allPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AllPointsCell.self, for: indexPath)
        cell.update(player: presenter.allPoints[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NewGameHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.headerTitle.text = "Turns"
        return headerView
    }
}

