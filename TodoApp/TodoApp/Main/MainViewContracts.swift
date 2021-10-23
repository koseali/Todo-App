//
//  MainViewContracts.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation

// MARK: VIEW
protocol MainViewProtocol {
    func handleOutput(_ output : MainViewPresenterOutput)
}

// MARK: INTERACTOR
protocol MainViewInteractorProtocol : AnyObject  {
    var  delegate : MainViewInteractorDelegate? { get set }
    func didload()
    func didSelectRow(at indexPath :IndexPath)
    func didSearchdata(with searchText : String)
    func deleteData(at indexPath : IndexPath)
    func didUpdateData()
    func didSortData(by isSorted : Bool)
}

protocol MainViewInteractorDelegate : AnyObject  {
    func handleOutput(_ output : MainViewInteractorOutput)
}

enum MainViewInteractorOutput {
    case showData([TodoTasks])
    case detailData(TodoTasks)
    case showSearchData([TodoTasks])
    case deletedata([TodoTasks])
    case showUpdateData([TodoTasks])
    case showEmpytDataView
    case sortData([TodoTasks],Bool)
}
// MARK: PRESENTER

protocol MainViewPresenterProtocol {
    func viewDidLoad()
    func didSelectRow(at indexPath :IndexPath)
    func didSearchTodo(with searchText : String)
    func didDeleteTodo(at indexPath: IndexPath)
    func didSortTodo(by isSorted : Bool )
    func didAddTodo()
    func didchangeTodo()
}


enum MainViewPresenterOutput {
    case showToDo([ToDoPresentation])
    case showSearchTodo([ToDoPresentation])
    case showDeletedTodo([ToDoPresentation])
    case showSortedTodo([ToDoPresentation], Bool)
    case showUpdatedTodo([ToDoPresentation])
    case showEmptyDataView
}

// MARK: ROUTER

protocol MainViewRouterProtocol   {
    func navigate(to route: MainViewRoute)
}

enum MainViewRoute {
    case showBookDetail(TodoTasks)
    case showAddView
}

