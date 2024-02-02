import UIKit

class AllPointsCell: UITableViewCell {

    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    static var reuseId = "AllPointsCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }
   
    //MARK: - update
    func update(player: Player) {
        nameLabel.text = player.name
        nameLabel.textColor = .white
        pointLabel.text = "\(player.points)"
        pointLabel.textColor = .white
    }
}


    //MARK: - setupConstraints
extension AllPointsCell {
    private func setupConstraints() {
        setupNameLabel()
        setupPointLabel()
    }
    
     func setupNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupPointLabel() {
        contentView.addSubview(pointLabel)
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pointLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            pointLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

