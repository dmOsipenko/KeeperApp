import UIKit

import UIKit

class MainTimer: UIView, TimerView {
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.backColor
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.text = "00:00"
        label.textAlignment = .center
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Play"), for: .normal)
        return button
    }()

    var counter = 0
    var timer = Timer()
    var isSelect: Bool = false
    
    var presenter: TimerPresenterProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = UIColor.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @objc private func timerAction() {
        counter += 1
        timerLabel.text = timeFormatted(counter)
    }
    
    @objc private func tapStart() {
        if isSelect {
            presenter?.pressStartButton()
        } else {
            presenter?.pressStopButton()
        }
    }
 
    //MARK: - TimerView method
    
    func start() {
        playButton.setImage(UIImage(named: "Play"), for: .normal)
        timerLabel.textColor = UIColor.backColor
        timer.invalidate()
        isSelect = false
    }
    
    func stop() {
        playButton.setImage(UIImage(named: "Pause"), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timerLabel.textColor = .white
        isSelect = true
    }
}


extension MainTimer {
    private func setupConstraints() {
        self.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 42),
            timerLabel.widthAnchor.constraint(equalToConstant: 85)
        ])

        self.addSubview(playButton)
        playButton.addTarget(self, action: #selector(tapStart), for: .touchUpInside)
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 20),
            playButton.widthAnchor.constraint(equalToConstant: 20),
            playButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            playButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
        ])
    }
}
