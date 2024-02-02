import UIKit

protocol AddPlayerView: AnyObject {
    func savePlayer(player: Player)
    func checkButton(isEnable: Bool)
}

protocol AddPlayerPresenterProtocol {
    func addPlayer(player: Player)
    func checkAddButton(text: String) 
}


class AddPlayerPresenter: AddPlayerPresenterProtocol {
    
    weak var view: AddPlayerView?
    
    func addPlayer(player: Player) {
        view?.savePlayer(player: player)
    }
    
    func checkAddButton(text: String) {
        text.isEmpty ? view?.checkButton(isEnable: false) : view?.checkButton(isEnable: true)
    }
}
