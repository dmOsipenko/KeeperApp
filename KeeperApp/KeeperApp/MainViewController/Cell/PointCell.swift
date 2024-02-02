import UIKit

class PointCell: UICollectionViewCell {
    
    var pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "0"
        return label
    }()
  
    static var reuseId = "PointCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        contentView.backgroundColor = UIColor.buttonColor
        contentView.layer.cornerRadius = contentView.frame.size.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PointCell {
    private func setupConstraints() {
        contentView.addSubview(pointLabel)
        
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pointLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pointLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
