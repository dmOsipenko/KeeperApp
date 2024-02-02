import UIKit

extension UIView {
    
    func setShadow(color: UIColor, height: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.masksToBounds = false
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

extension String {
    func addPlus(points: Int) -> String {
        if points < 0 {
            return "-\(self)"
        } else {
            return "+\(self)"
        }
    }
}

