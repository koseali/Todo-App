//
//  DetailViewBuilder.swift
//  TodoApp
//
//  Created by Ali Kose on 20.10.2021.
//

import Foundation

class DetailViewBuilder {
    static func build(with todo : TodoTasks, screenType : builderChoice) -> DetailViewController {
        let view = DetailViewController()
        let viewModel = DetailViewModel(todoItem: todo, dataManager: appContainer.dataManager, notificationManager: LocalNotificationManager())
        viewModel.screenType = screenType
        view.viewModel = viewModel
        return view
    }
    
    deinit {
        print("DetailViewBuilder deinit oldu.")
    }
    
   
}
