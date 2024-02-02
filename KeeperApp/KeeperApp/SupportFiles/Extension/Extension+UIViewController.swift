
import UIKit

extension UIViewController {
    func hideBlurEffect() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideBlur))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideBlur() {
        view.subviews.forEach({
            if let blur = $0 as? BlurView {
                blur.removeFromSuperview()
        }})
    }
}
