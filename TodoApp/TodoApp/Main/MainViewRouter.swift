//
//  MainViewRouter.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation
import UIKit

class MainvViewRouter : MainViewRouterProtocol {
    var view : UIViewController
    init(view : UIViewController){
        self.view = view
    }
    
    func navigate(to route: MainViewRoute) {
        switch route {
        case .showTodoDetail(let todoTasks):
    
            let detailView = DetailViewBuilder.build(with: todoTasks,
                                                     screenType: .DetailView)
            view.navigationController?.pushViewController(detailView, animated: true)
            
        case .showAddView:

            let addView = DetailViewBuilder.build(with: TodoTasks(), screenType: .AddView)
            view.navigationController?.pushViewController(addView, animated: true)
        }
    }
    deinit {
        print("MainViewRouter deinit oldu.")
    }
}
