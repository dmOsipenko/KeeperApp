import Foundation

import UIKit

class DynamicHeightTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}
