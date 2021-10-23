//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by Ali Kose on 8.10.2021.
//

import Foundation
import CoreData

// TODO: VIEWMODEL VE INTERACTOR ICIN DATAMANGER PROTOCOL DUZGUN OLUSTURUP ORALARDA BUNLARI CAGIR.
// Completion neden kullandigimi hatirlamiyorum
//    func saveData( title : String, subtitle : String, date : String,completion: ((Bool) ->()))
protocol DataManagerProtocol {
    func updateData(todoItem : TodoTasks, title : String, subtitle : String, date : String)
    func saveData( title : String, subtitle : String, date : String)
    func fetchData() -> [TodoTasks]
    func deleteData(todoItem : TodoTasks)
    func sortbyCreatedData() -> [TodoTasks]
    func searchData(with : String) -> [TodoTasks]
}

class CoreDataManager : DataManagerProtocol {
    
    // TODO: - BUNU BURADAN SILmeyi unutma test data  icin ekliyorm
    static let  shared = CoreDataManager()
 
    // MARK: - Core Data stack
    // Sadece  test data eklemek icin shared kullanildi.
    // static let shared = CoreDataManager()
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Core Data Functions
    
    func saveData( title : String, subtitle : String, date : String ) {
        let manageContext = persistentContainer.viewContext
        let model = TodoTasks(context: manageContext )
        model.title = title
        model.detail = subtitle
        model.deadlineDate = date
        model.createdDate = Date()
        do {
            if manageContext.hasChanges{
                try  manageContext.save()
                print("Basariyla kaydedildi.")
                
            }
            
        } catch  {
            debugPrint("Kaydetme hatasi: \(error.localizedDescription)")
        }
    }
    
    func updateData(todoItem : TodoTasks, title : String, subtitle : String, date : String) {
        let manageContext = persistentContainer.viewContext
        todoItem.title = title
        todoItem.detail = subtitle
        todoItem.deadlineDate = date
        todoItem.createdDate = Date()
        
        do {
            if manageContext.hasChanges{
                try manageContext.save()
                print("Basariyla  Guncellendi.")
            }
        } catch  {
            print("Basarisiz Guncelleme oldu")
            debugPrint("Guncelleme hatasi: \(error.localizedDescription)")
        }
    }
    
    
    func deleteData(todoItem : TodoTasks) {
        let manageContext = persistentContainer.viewContext
        manageContext.delete(todoItem)
        do {
            try  manageContext.save()
            print("Basariyla Silindi.")
        } catch  {
            debugPrint("Silme hatasi: \(error.localizedDescription)")
        }
    }
    
    
    func fetchData() -> [TodoTasks] {
        
        let request = NSFetchRequest<TodoTasks>(entityName: "TodoTasks")
        let manageContext = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try manageContext.fetch(request)
            print("Basariyla CoreData Veriler alindi.")
            return result
            
        } catch {
            debugPrint("Veri Cekme hatasi: \(error.localizedDescription)")
        }
        return []
    }
    
    func sortbyCreatedData() -> [TodoTasks] {
        let manageContext = persistentContainer.viewContext
        let request = NSFetchRequest<TodoTasks>(entityName: "TodoTasks")
        let sorter = NSSortDescriptor(key: "createdDate", ascending: false)
        request.sortDescriptors = [sorter]
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageContext.fetch(request)
            print("Result icinde ne var \(result)")
            return result
            
        } catch {
            debugPrint("Siralama hatasi: \(error.localizedDescription)")
        }
        return []
    }
    
    func searchData(with : String) -> [TodoTasks]{
        let manageContext = persistentContainer.viewContext
        let request = NSFetchRequest<TodoTasks>(entityName: "TodoTasks")
        request.predicate = NSPredicate(format: "title contains[c] '\(with)'")
        
        do {
            let data = try manageContext.fetch(request)
            return data
        } catch  {
            debugPrint("Arama hatasi: \(error.localizedDescription)")
        }
        return []
    }
    
    func addTestData(title : String , detailTitle : String , deadlineDate : String){
        let manageContext = persistentContainer.viewContext
        let newData = NSEntityDescription.insertNewObject(forEntityName: "TodoTasks", into: manageContext)
        newData.setValue(title, forKey: "title")
        newData.setValue(detailTitle, forKey: "detail")
        newData.setValue(deadlineDate, forKey: "deadlineDate")
        newData.setValue(Date(), forKey: "createdDate")
        
        do {
            try manageContext.save()
            print("Test verisi eklendi")
            
        } catch {
            debugPrint("Test veri ekleme hatasi: \(error.localizedDescription)")
        }
    }
    
    deinit {
        print("CoreDataManager deinit oldu.")
    }
}
/* Test DATASI OLUSTURMA
 
 CoreDataManager.shared.addTestData(title: "Anasayfa ekleme", detailTitle: "Ayni sayfa uzerinde build etme nasil olur", deadlineDate: "22.10.2021 00:00")
 CoreDataManager.shared.addTestData(title: "Test Yaz", detailTitle: "Managerlara test yaz", deadlineDate: "23.10.2021 09:00")
 CoreDataManager.shared.addTestData(title: "Git entegrasyonu gerceklestir.",
 detailTitle: "git flow a gore olustur",
 deadlineDate: "23.10.2021 00:00")
 */
