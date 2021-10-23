//
//  MainViewInteractor.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation

class MainViewInteractor : MainViewInteractorProtocol {

    private var todos : [TodoTasks] = []
    var dataManager : DataManagerProtocol!
   weak var delegate: MainViewInteractorDelegate?
    
    func didload() {
        todos = dataManager.fetchData()
        if todos.count > 0 {
            delegate?.handleOutput(.showData(todos))
        } else {
            delegate?.handleOutput(.showEmpytDataView)
        }
     
        // presenter da view a versin ona gore bos ekran donsun
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        delegate?.handleOutput(.detailData(todo))
    }
    
    func didSearchdata(with searchText: String) {
         
        todos = searchText.isEmpty ? dataManager.fetchData() :  dataManager.searchData(with: searchText)
        // ternary operator daha iyi oldu
//        if !searchText.isEmpty{
//            todos = dataManager.searchData(with: searchText)
//        } else {
//            todos = dataManager.fetchData()
//        }
        delegate?.handleOutput(.showSearchData(todos))
    }
    
    func deleteData(at indexPath: IndexPath) {
        let data = todos[indexPath.row]
        dataManager.deleteData(todoItem : data)
        todos = dataManager.fetchData()
        delegate?.handleOutput(.deletedata(todos))
    }
    func didUpdateData() {
        if appContainer.ischange == true {
            todos = dataManager.fetchData()
            delegate?.handleOutput(.showUpdateData(todos))
           
            appContainer.ischange = false
        }
    }
    func didSortData(by isSorted: Bool) {
        todos = isSorted  ? dataManager.fetchData() : dataManager.sortbyCreatedData()
        let flag = isSorted ? false : true
        if todos.count > 0 {
            delegate?.handleOutput(.sortData(todos, flag ))
        } else {
            delegate?.handleOutput(.showEmpytDataView)
        }
    }
    deinit {
        print("MainViewInteractor deinit oldu.")
    }
}
