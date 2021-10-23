//
//  DetailViewModel.swift
//  TodoApp
//
//  Created by Ali Kose on 20.10.2021.
//

import Foundation

class DetailViewModel : DetailViewModelProtocol {
    
    weak var delegate: DetailViewModelDelegate?
    var todoItem : TodoTasks
    var screenType : builderChoice!
    var dataManager : DataManagerProtocol
    var notificationManager  : NotificationManagerProtocol
    
    init(todoItem : TodoTasks, dataManager : DataManagerProtocol, notificationManager  : NotificationManagerProtocol){
        self.todoItem = todoItem
        self.dataManager = dataManager
        self.notificationManager = notificationManager
    }
    
    
    func didLoad() {
        switch screenType {
        case .DetailView:
            delegate?.handleOutput(.showToDoDetail(ToDoPresentation.init(todo: todoItem)))
        case .AddView:
            delegate?.handleOutput(.showToDoAdd)
        case .none:
            print("Ekran coker :)")
        }
    }
    
    func addTodo(title: String, detail: String, deadlineDate: String , date : Date) {
        
        switch screenType {
            
        case .AddView:
            if title != "" {
                print("Schedule olmus ve listede bekleyenler:")
                notificationManager.listScheduledNotifications()
                
                dataManager.saveData(title: title, subtitle: detail, date: deadlineDate)
                let dateComponent = Calendar.current.dateComponents([.year,.month,.day, .hour, .minute], from: date)
                let notification = Notification(id: UUID().uuidString, title: title, subTitle: detail, date: dateComponent)
                notificationManager.notifications.append(notification)
                notificationManager.schedule()
                print(notification)
                appContainer.ischange = true
                delegate?.navigate(to: .saveAndBack)
            } else {
                delegate?.handleOutput(.showAlert)
            }
            
        case .DetailView:
            if  todoItem.title == title  && todoItem.detail == detail && todoItem.deadlineDate == deadlineDate  {
                // Degisiklik olmadiginda secilen veride sayfa yenilenmiyor.
                delegate?.navigate(to: .goBack)
            } else {
                // eski notification once bildrimini siliyorum eskiden gelen title a gore
                notificationManager.deleteOldNotificationForUpdate(title: title)
                dataManager.updateData(todoItem: todoItem, title: title, subtitle: detail, date: deadlineDate)
                // Veri tabani guncelledikten sonra tekrar bildirim ekliyorum
                let dateComponent = Calendar.current.dateComponents([.year,.month,.day, .hour, .minute], from: date)
                let notification : Notification = Notification(id: UUID().uuidString , title: title, subTitle: detail, date: dateComponent)
                notificationManager.notifications.append(notification)
                notificationManager.schedule()
                appContainer.ischange = true
                delegate?.navigate(to: .saveAndBack)
            }
            
        case .none:
            print("Beklenmeyen Ekran Gecisi Gerceklesti.")
        }
    }
    
    func goBack() {
        delegate?.navigate(to: .goBack)
    }
    
    
    deinit {
        print("DetailViewModel deinit oldu.")
    }
    
}


