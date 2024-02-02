
import UIKit

class NameCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "J"
        return label
    }()
  
    static var reuseId = "NameCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - update
    func update(player: Player) {
        nameLabel.text = player.name.first?.uppercased()
    }
}

extension NameCell {
    private func setupConstraints() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}

