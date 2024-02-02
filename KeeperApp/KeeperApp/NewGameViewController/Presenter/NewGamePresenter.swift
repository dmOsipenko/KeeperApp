import UIKit

protocol BasePresenter {
    func viewWillAppear()
}

protocol NewGameView: AnyObject {
    func reloadData()
    func cancel()
    func showAddViewController(vc: UIViewController)
    func showMainViewController(vc: UIViewController)
}

protocol NewGamePresenterProtocol: BasePresenter {
    var players: [Player] { get }
    func addPlayers(player: Player)
    func deleteCell(indexPath: IndexPath)
    func tapCancelButton()
    func tapMainButton()
    func tapAddButton(vc: UIViewController)
    func isCheckButtonEnable() -> Bool
    func countPlayers() -> Int
    func changePlayerPosition(from fromIndex: Int, to toIndex: Int)
}


class NewGamePresenter: NewGamePresenterProtocol {

    weak var view: NewGameView?
    var players: [Player] = []
    
    
    func viewWillAppear() {
        view?.reloadData()
    }
    
    func addPlayers(player: Player) {
        players.append(player)
        view?.reloadData()
    }
    
    func deleteCell(indexPath: IndexPath) {
        players.remove(at: indexPath.row)
    }
    
    func tapCancelButton() {
        view?.cancel()
    }
    
    func tapMainButton() {
        let mainPresenter = MainPresenter()
        let mainViewController = MainViewController(presenter: mainPresenter)
        mainPresenter.view = mainViewController
        mainPresenter.players = players
        view?.showMainViewController(vc: mainViewController)
    }
    
    func tapAddButton(vc: UIViewController) {
        view?.showAddViewController(vc: vc)
    }
    
    func isCheckButtonEnable() -> Bool {
        !players.isEmpty
    }
    
    func countPlayers() -> Int {
        players.count
    }
    
    func changePlayerPosition(from fromIndex: Int, to toIndex: Int) {
        guard players.count >= fromIndex else {
            return
        }

        let tmp = players[fromIndex]
        players.remove(at: fromIndex)
        players.insert(tmp, at: toIndex)

        view?.reloadData()
    }
}
