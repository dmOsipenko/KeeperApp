import UIKit

protocol SelectPointButtonProtocol: AnyObject {
    func tapPointButton(point: Int)
}

class PointButton: UIButton {
    
    var pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textAlignment = .center
        return label
    }()
    
    weak var delegate: SelectPointButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.buttonColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
    @objc func tapPointButton() {
        guard let pointString = pointLabel.text, let point = Int(pointString)  else {return}
        delegate?.tapPointButton(point: point)
    }
    
}

extension PointButton {
    private func setupConstraints() {
        self.addSubview(pointLabel)
        self.addTarget(self, action: #selector(tapPointButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: self.topAnchor),
            pointLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pointLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            pointLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
