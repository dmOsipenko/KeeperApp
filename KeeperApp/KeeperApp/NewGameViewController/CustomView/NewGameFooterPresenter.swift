import UIKit


protocol FooterView: AnyObject {
    func showAddViewController(vc: UIViewController)
    func player(player: Player)
}

protocol NewGameFooterPresenterProtocol {
    func tapAddButton()
    func getPlayers(player: Player)
}


class NewGameFooterPresenter: NewGameFooterPresenterProtocol {
   
    weak var view: FooterView?
    
    func tapAddButton() {
        let addPlayerPresenter = AddPlayerPresenter()
        let addPlayerViewController = AddPlayerViewController(presenter: addPlayerPresenter)
        addPlayerPresenter.view = addPlayerViewController
        addPlayerViewController.addBlock = { [weak self] player in
            self?.getPlayers(player: player)
        }
        view?.showAddViewController(vc: addPlayerViewController)
    }
    
    func getPlayers(player: Player) {
        view?.player(player: player)
    }
}
