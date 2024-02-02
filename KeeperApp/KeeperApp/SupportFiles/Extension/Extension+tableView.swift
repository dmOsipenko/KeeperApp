import UIKit

extension UITableView {
    func registerCell(_ cellClass: AnyClass) {
        let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: cellClass.self))
    }
    
    func setupDelegateData(_ controller: UIViewController) {
        self.delegate = controller as? UITableViewDelegate
        self.dataSource = controller as? UITableViewDataSource
        self.tableFooterView = UIView()
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
        else {
            fatalError("Could not deque cell with type \(T.self)")
        }
        cell.awakeFromNib()
        return cell
    }
}
