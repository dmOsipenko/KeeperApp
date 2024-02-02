import UIKit

class MainViewController: BaseViewController, MainView {

   private let diceIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_Dice"), for: .normal)
        return button
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let timerView: MainTimer = {
        let view = MainTimer()
        let presenter = TimerPresenter(view: view)
        view.presenter = presenter
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameView: NameView = {
        let view = NameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var undoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Undo"), for: .normal)
        return button
    }()
    
    private let mainPointView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.buttonColor
        view.layer.cornerRadius = 45
        return view
    }()
    
    private var pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "+1"
        return label
    }()
    
    private var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_Previous"), for: .normal)
        return button
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_Next"), for: .normal)
        return button
    }()
    
    private var pointCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        return cv
    }()
    
    private var pointButton1: PointButton = {
        let button = PointButton(frame: .zero)
        button.pointLabel.text = "-10"
        return button
    }()
    
    private var pointButton2: PointButton = {
        let button = PointButton(frame: .zero)
        button.pointLabel.text = "-5"
        return button
    }()
    
    private var pointButton3: PointButton = {
        let button = PointButton(frame: .zero)
        button.pointLabel.text = "-1"
        return button
    }()
    
    private var pointButton4: PointButton = {
        let button = PointButton(frame: .zero)
        button.pointLabel.text = "+5"
        return button
    }()
    
    private var pointButton5: PointButton = {
        let button = PointButton(frame: .zero)
        button.pointLabel.text = "+10"
        return button
    }()

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    var presenter: MainPresenterProtocol
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupConstraints()
        hideBlurEffect()
        startTimer()
        setFirstLetter()
        checkIsEnableUndoButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    private func startTimer() {
        timerView.presenter?.pressStopButton()
    }
    
    private func setFirstLetter() {
        nameView.players = presenter.players
    }
    
    private func checkIsEnableUndoButton() {
//        undoButton.isEnabled = presenter.isCheckButtonEnable()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseId)
    }
    
    private func setupUI() {
        titleText.text = "Game"
        setupLeftItem(title: "New Game")
        setupRightItem(title: "Results")
    }
    
    override func tapLeft() {
        presenter.tapNewGameButton()
    }
    
    override func tapRight() {
        presenter.tapResumeButton()
    }
    
    @objc func tapUndoButton() {
        presenter.tapUndo()
    }
    
    @objc func tapDice() {
        presenter.tapDiceButton()
    }
    
    @objc func tapPrevious() {
        presenter.tapPrevious()
    }
    
    @objc func tapNext() {
        presenter.tapNext()
    }
    
    //MARK: - MainView method
    func blurEffect() {
        let blurView = BlurView(frame: view.bounds)
        view.addSubview(blurView)
    }
    
    func returnPoints(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    func addPoint(point: Int, indexPath: IndexPath) {
        pointLabel.text = point < 0 ? "\(point)" : "+\(point)"
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    func next(indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func previous(indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func presentNewGame(vc: UIViewController) {
        navigationController?.present(vc, animated: true)
    }
    
    func showResultViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}


//MARK: - SelectPointButtonProtocol
extension MainViewController: SelectPointButtonProtocol {
    func tapPointButton(point: Int) {
        presenter.tapPoint(point: point)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.playersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseId, for: indexPath)
        guard let card = cell as? CardCell else {return cell}
        card.update(player: presenter.players[indexPath.row])
        return card
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 1.5
        let width = collectionView.frame.width
        let withPerItem = width / itemPerRow
        return CGSize(width: withPerItem, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else {return}
        presenter.indexPath = indexPath
        nameView.update(indexPath: indexPath)
    }
}

//MARK: - MainViewController
extension MainViewController {
    
    private func setupConstraints() {
        setupTimerView()
        setupDiceIcon()
        setupCollection()
        setupMainPointView()
        setupPointLabel()
        setupPreviousButton()
        setupNextButton()
        setupStackView()
        setupStackView()
        setupNameView()
        setupUndoButton()
    }
    
    private func setupTimerView() {
        view.addSubview(timerView)
        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            timerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupDiceIcon() {
        view.addSubview(diceIcon)
        diceIcon.addTarget(self, action: #selector(tapDice), for: .touchUpInside)
        NSLayoutConstraint.activate([
            diceIcon.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            diceIcon.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            diceIcon.heightAnchor.constraint(equalToConstant: 30),
            diceIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCollection() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupMainPointView() {
        view.addSubview(mainPointView)
        NSLayoutConstraint.activate([
            mainPointView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            mainPointView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainPointView.heightAnchor.constraint(equalToConstant: 90),
            mainPointView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupPointLabel() {
        mainPointView.addSubview(pointLabel)
        NSLayoutConstraint.activate([
            pointLabel.topAnchor.constraint(equalTo: mainPointView.topAnchor),
            pointLabel.bottomAnchor.constraint(equalTo: mainPointView.bottomAnchor),
            pointLabel.leftAnchor.constraint(equalTo: mainPointView.leftAnchor),
            pointLabel.rightAnchor.constraint(equalTo: mainPointView.rightAnchor)
        ])
    }
    
    private func setupPreviousButton() {
        view.addSubview(previousButton)
        previousButton.addTarget(self, action: #selector(tapPrevious), for: .touchUpInside)
        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 60),
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            previousButton.heightAnchor.constraint(equalToConstant: 30),
            previousButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 60),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 30),
            nextButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(pointButton1)
        stackView.addArrangedSubview(pointButton2)
        stackView.addArrangedSubview(pointButton3)
        stackView.addArrangedSubview(pointButton4)
        stackView.addArrangedSubview(pointButton5)
        stackView.arrangedSubviews.forEach({
            guard let button = $0 as? PointButton else {return}
            button.delegate = self
            
        })
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainPointView.bottomAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupNameView() {
        view.addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            nameView.widthAnchor.constraint(equalToConstant: 80),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupUndoButton() {
        view.addSubview(undoButton)
        undoButton.addTarget(self, action: #selector(tapUndoButton), for: .touchUpInside)
         NSLayoutConstraint.activate([
            undoButton.centerYAnchor.constraint(equalTo: nameView.centerYAnchor, constant: -3),
            undoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            undoButton.heightAnchor.constraint(equalToConstant: 20),
            undoButton.widthAnchor.constraint(equalToConstant: 15)
         ])
    }
}
