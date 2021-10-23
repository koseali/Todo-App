//
//  AppContainer.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation

var appContainer = AppContainer()

class AppContainer {
    var router = AppRouter()
    var dataManager = CoreDataManager()
    var ischange = false
}
