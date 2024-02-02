import UIKit

class ResultView: UIStackView {
    
    private var tableView: DynamicHeightTableView = {
        let view = DynamicHeightTableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    var players: [Player] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupTableView()
        self.distribution = .equalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupTableView() {
        tableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ResultView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ResultCell.self, for: indexPath)
        cell.update(player: players[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension ResultView {
    private func setupConstraints() {
        self.addArrangedSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
