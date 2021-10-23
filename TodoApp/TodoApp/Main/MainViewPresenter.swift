//
//  MainViewPresenter.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation

class MainViewPresenter : MainViewPresenterProtocol {
    
    var mainView : MainViewProtocol
    var router : MainViewRouterProtocol
    var interactor : MainViewInteractorProtocol! {
        didSet {
            interactor.delegate = self
        }
    }
    
    // init de  interactoru vermedim cunku veri gelmiyor ?
    // Derste yasanilan problem builder da parametreyLe veriyi gectim.
    
    init(mainView : MainViewProtocol, router : MainViewRouterProtocol){
        self.mainView = mainView
        self.router = router
    }
    func viewDidLoad() {
        interactor.didload()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
    func didSearchTodo(with searchText: String) {
        interactor.didSearchdata(with: searchText)
    }
    func didDeleteTodo(at indexPath: IndexPath) {
        interactor.deleteData(at: indexPath)
    }
    
    func didSortTodo(by isSorted: Bool) {
        interactor.didSortData(by: isSorted)
    }
    
    func didchangeTodo()  {
        interactor.didUpdateData()
    }
    func didAddTodo() {
        router.navigate(to: .showAddView)
    }
    deinit {
        print("MainViewPresenter deinit oldu.")
    }
    
}

extension MainViewPresenter : MainViewInteractorDelegate {
    func handleOutput(_ output: MainViewInteractorOutput) {
        switch output {
        case .showData(let todos):
            let data = todos.map(ToDoPresentation.init)
            mainView.handleOutput(.showToDo(data))
            
        case .detailData(let todo):
            router.navigate(to: .showTodoDetail(todo))
            
        case .showSearchData(let searchDatas):
            let data = searchDatas.map(ToDoPresentation.init)
            mainView.handleOutput(.showSearchTodo(data))
            
        case .deletedata(let deletedDatas):
            let data = deletedDatas.map(ToDoPresentation.init)
            mainView.handleOutput(.showDeletedTodo(data))
        case .showUpdateData(let updatedDatas):
            let data = updatedDatas.map(ToDoPresentation.init)
            mainView.handleOutput(.showUpdatedTodo(data))
        case .sortData(let sortedDatas, let flag):
            let data = sortedDatas.map(ToDoPresentation.init)
            mainView.handleOutput(.showSortedTodo(data, flag))
        case .showEmpytDataView:
            mainView.handleOutput(.showEmptyDataView)
        }
    }
}
