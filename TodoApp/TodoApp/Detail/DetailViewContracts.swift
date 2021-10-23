//
//  DetailContracts.swift
//  TodoApp
//
//  Created by Ali Kose on 20.10.2021.
//

import Foundation

// MARK: VIEWMODEL

protocol DetailViewModelProtocol : AnyObject {
    var delegate : DetailViewModelDelegate? { get set }
    func didLoad()
    func addTodo(title: String , detail : String , deadlineDate : String, date : Date)
    func goBack()
}
protocol DetailViewModelDelegate : AnyObject {
    func handleOutput(_ output : ViewModelOutput)
    func navigate(to route : DetailViewRouter)
}

enum DetailViewRouter {
    case goBack
    case saveAndBack
}

enum ViewModelOutput {
    case showToDoDetail(ToDoPresentation)
    case showToDoAdd
    case showAlert
    
}
// MARK: BUILDER SCREEN TYPE

enum builderChoice {
    case DetailView
    case AddView
}
