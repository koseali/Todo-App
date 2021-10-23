//
//  ToDoPresentation.swift
//  TodoApp
//
//  Created by Ali Kose on 20.10.2021.
//

import Foundation

struct ToDoPresentation{
    let title : String
    let detail : String
    let deadlineDate : String
    
    init(title : String, detail : String, deadlineDate : String) {
        self.title = title
        self.detail = detail
        self.deadlineDate = deadlineDate
        
    }
    init(todo : TodoTasks){
       //  guard let title = todo.title , let detail =  todo.detail , let deadlineDate = todo.deadlineDate else{return nil}
        // force wrap yaptim TodoTask modelde optiona old icin
        self.init(title: todo.title!, detail: todo.detail!, deadlineDate: todo.deadlineDate!)
    }
}
