import UIKit


class BlurView: UIView {
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    lazy var diceImage = UIImageView(frame: CGRect(x: self.center.x - 60, y: self.center.y - 60, width: 120, height: 120))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        feedbackGenerator.impactOccurred()
        self.addBlurEffect()
        setDice()
        setDiceImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setDice() {
        let random = Int.random(in: 1 ... 6)
        print(random)
        switch random {
        case 1:
            diceImage.image = UIImage(named: "dice_1")
        case 2:
            diceImage.image = UIImage(named: "dice_2")
        case 3:
            diceImage.image = UIImage(named: "dice_3")
        case 4:
            diceImage.image = UIImage(named: "dice_4")
        case 5:
            diceImage.image = UIImage(named: "dice_5")
        case 6:
            diceImage.image = UIImage(named: "dice_6")
        default:
            print("Default")
        }
    }
    
    private func setDiceImage() {
        self.addSubview(diceImage)
        diceImage.center = self.center
    }
}
