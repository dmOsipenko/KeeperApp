import UIKit

protocol ResumeView: AnyObject {
    func presentNewGame(vc: UIViewController)
}

protocol ResumePresenterProtocol {
    var players: [Player] {get set}
    var allPoints: [Player] {get set}
    func countPlayers() -> Int
    func tapNewGameButton() 
}


class ResumePresenter: ResumePresenterProtocol {
    var allPoints: [Player] = []
    var players: [Player] = []
    weak var view: ResumeView?
    
    func countPlayers() -> Int {
        players.count
    }
    
    func tapNewGameButton() {
        let newGamePresenter = NewGamePresenter()
        let newGameViewController = NewGameViewController(presenter: newGamePresenter)
        newGamePresenter.view = newGameViewController
        newGameViewController.setupLeftItem(title: "Cancel")
        let navigationController = UINavigationController(rootViewController: newGameViewController)
        view?.presentNewGame(vc: navigationController)
    }
}

