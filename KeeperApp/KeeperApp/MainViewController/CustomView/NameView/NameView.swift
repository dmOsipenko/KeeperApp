import UIKit


class NameView: UIView {
    
   private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var players: [Player] = []
    var currentIndexPath: IndexPath = [0,0]
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NameCell.self, forCellWithReuseIdentifier: NameCell.reuseId)
    }
    
    func update(indexPath: IndexPath) {
        currentIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
 }


extension NameView {
    private func setupConstraints() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NameView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameCell.reuseId, for: indexPath)
        guard let nameCell = cell as? NameCell else {return cell}
        nameCell.update(player: players[indexPath.row])
        if currentIndexPath.row == indexPath.row {
            nameCell.nameLabel.textColor = .white
        } else {
            nameCell.nameLabel.textColor = .lightGray
        }
        return nameCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 3
        let width = collectionView.frame.width
        let withPerItem = width / itemPerRow
        return CGSize(width: withPerItem, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
