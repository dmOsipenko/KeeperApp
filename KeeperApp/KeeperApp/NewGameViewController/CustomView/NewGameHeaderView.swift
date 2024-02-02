import UIKit


class NewGameHeaderView: UIView {
    
    var headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont(name: "Nunito-Bold", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Players"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        self.addSubview(headerTitle)
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            headerTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            headerTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
}
