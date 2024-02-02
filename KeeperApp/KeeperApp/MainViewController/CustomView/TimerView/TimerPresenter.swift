
import UIKit

protocol TimerView: AnyObject {
    func start()
    func stop()
}

protocol TimerPresenterProtocol {
    init(view: TimerView)
    func pressStartButton()
    func pressStopButton()
}


class TimerPresenter: TimerPresenterProtocol {
    
    weak var view: TimerView?
    
    required init(view: TimerView) {
        self.view = view
    }
    func pressStartButton() {
        view?.start()
    }
    
    func pressStopButton() {
        view?.stop()
    }
}


