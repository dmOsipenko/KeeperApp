import UIKit

class CardCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.orangeColor
        label.font = UIFont(name: "Nunito-Bold", size: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Name"
        return label
    }()
    
    var pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-Bold", size: 100)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "0"
        return label
    }()
  
    static var reuseId = "CardCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUI()
    }
    
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.backColor
        contentView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - update
    func update(player: Player) {
        nameLabel.text = player.name
        pointLabel.text = "\(player.points)"
    }
}


extension CardCell {
     func setupConstraints() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(pointLabel)
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 60),
            pointLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            pointLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
        ])
    }
}
