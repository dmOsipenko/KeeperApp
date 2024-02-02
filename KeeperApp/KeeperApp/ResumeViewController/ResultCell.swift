import UIKit

class ResultCell: UITableViewCell {

    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    static var reuseId = "ResultCell"
    
    
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
    func update(player: Player, indexPath: IndexPath) {
        numberLabel.text = "#\(indexPath.row + 1)"
        numberLabel.textColor = .white
        nameLabel.text = player.name
        nameLabel.textColor = UIColor.orangeColor
        pointLabel.text = "\(player.points)"
        pointLabel.textColor = .white
    }
}


    //MARK: - setupConstraints
extension ResultCell {
    private func setupConstraints() {
        setupNumberLabel()
        setupPointLabel()
        setupNameLabel()
    }
    
     func setupNumberLabel() {
        contentView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            numberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            numberLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupPointLabel() {
        contentView.addSubview(pointLabel)
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pointLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: pointLabel.leftAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
