//
//  MainViewBuilder.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation
import UIKit

class MainViewBuilder {
    static func build()->MainViewController {
        let storyBoard = UIStoryboard(name: "MainView", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let interactor = MainViewInteractor()
        let rooter = MainvViewRouter(view: view)
        interactor.dataManager = appContainer.dataManager
        let presenter = MainViewPresenter(mainView: view, router: rooter)
        presenter.interactor = interactor
        view.presenter = presenter
        return view
    }
    deinit {
        print("MainView Builder Classı deinit oldu.")
    }
   
}
