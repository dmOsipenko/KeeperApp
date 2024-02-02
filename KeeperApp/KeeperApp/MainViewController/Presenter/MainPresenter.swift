import UIKit

protocol MainView: AnyObject {
    func blurEffect()
    func addPoint(point: Int, indexPath: IndexPath)
    func next(indexPath: IndexPath)
    func previous(indexPath: IndexPath)
    func presentNewGame(vc: UIViewController)
    func showResultViewController(vc: UIViewController)
    func returnPoints(indexPath: IndexPath)
    func reloadData()
}

protocol MainPresenterProtocol: BasePresenter {
    var players: [Player] {get}
    var allPoints: [Player] {get}
    var indexPath: IndexPath {get set}
    var playerCount: Int {get set}
    func tapDiceButton()
    func tapPoint(point: Int)
    func tapPrevious()
    func tapNext()
    func tapNewGameButton()
    func playersCount() -> Int
    func tapResumeButton()
    func tapUndo()
    func isCheckButtonEnable() -> Bool
}


class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainView?
    var players: [Player] = []
    var allPoints: [Player] = []
    var indexPath: IndexPath = [0,0]
    var playerCount: Int = 1
    
    func viewWillAppear() {
        view?.reloadData()
    }
    
    func tapDiceButton() {
        view?.blurEffect()
    }
    
    func tapPoint(point: Int) {
        let pointHistory = Player(name: players[indexPath.row].name, points: point)
        allPoints.append(pointHistory)
        players[indexPath.row].points += point
        let index = IndexPath(row: indexPath.row + 1, section: 0)
        index.row < players.count ? view?.addPoint(point: point, indexPath: index) : view?.addPoint(point: point, indexPath: [0,0])
    }
    
    func tapPrevious() {
        let index = IndexPath(row: indexPath.row - 1, section: 0)
        if index.row >= 0 {
            view?.next(indexPath: index)
        } else {
            view?.next(indexPath: [0, players.count - 1])
        }
    }
    
    func tapNext() {
        let index = IndexPath(row: indexPath.row + 1, section: 0)
        if index.row < players.count {
            view?.next(indexPath: index)
        } else {
            view?.next(indexPath: [0,0])
        }
    }
    
    func tapUndo() {
        
//        if allPoints.count > 0 {
//            allPoints.removeLast()
//            let index = IndexPath(row: indexPath.row - 1, section: 0)
//            if index.row >= 0 {
//                players[index.row].points -= allPoints.last?.points ?? 0
//                view?.returnPoints(indexPath: index)
//            } else {
//                players[players.count - 1].points -= allPoints.last?.points ?? 0
//                view?.returnPoints(indexPath: [0, players.count - 1])
//            }
//        } else {
//            return
//        }
    }
    
    func playersCount() -> Int {
        players.count
    }
    
    func isCheckButtonEnable() -> Bool {
        !players.isEmpty
    }
    
    func tapNewGameButton() {
        let newGamePresenter = NewGamePresenter()
        let newGameViewController = NewGameViewController(presenter: newGamePresenter)
        newGamePresenter.view = newGameViewController
        newGameViewController.setupLeftItem(title: "Cancel")
        let navigationController = UINavigationController(rootViewController: newGameViewController)
        view?.presentNewGame(vc: navigationController)
    }
    
    func tapResumeButton() {
        let resumePresenter = ResumePresenter()
        let resumeViewController = ResumeViewController(presenter: resumePresenter)
        resumePresenter.view = resumeViewController
        resumeViewController.presenter.players = players
        resumeViewController.presenter.allPoints = allPoints
        view?.showResultViewController(vc: resumeViewController)
    }
}
