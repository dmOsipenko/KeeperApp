import UIKit

protocol DeleteCellProtocol: AnyObject {
    func deleteCell(indexPath: IndexPath)
}

class NewGameCell: UITableViewCell {
    
    private let deleteIcon: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "icon_Delete"), for: .normal)
        return view
    }()
    
    private let sortIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "icon_Sort")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-Bold", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var indexPath: IndexPath?
    
    static var reuseId = "NewGameCell"
    weak var delegate: DeleteCellProtocol?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.backColor
    }
    
    @objc private func tapDelete() {
        delegate?.deleteCell(indexPath: indexPath ?? [0,0])
    }
   
    //MARK: - update
    func update(player: Player, indexPath: IndexPath) {
        nameLabel.text = player.name
        self.indexPath = indexPath
    }
}


    //MARK: - setupConstraints
extension NewGameCell {
    private func setupConstraints() {
        setupDeleteIcon()
        setupSortIcon()
        setupNameLabel()
        setuplineView()
    }
    
    private func setupDeleteIcon() {
        contentView.addSubview(deleteIcon)
        deleteIcon.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)
        NSLayoutConstraint.activate([
            deleteIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            deleteIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            deleteIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            deleteIcon.heightAnchor.constraint(equalToConstant: 25),
            deleteIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupSortIcon() {
        contentView.addSubview(sortIcon)
        NSLayoutConstraint.activate([
            sortIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23),
            sortIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            sortIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            sortIcon.heightAnchor.constraint(equalToConstant: 8),
            sortIcon.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.rightAnchor.constraint(equalTo: sortIcon.leftAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: deleteIcon.rightAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setuplineView() {
        contentView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
