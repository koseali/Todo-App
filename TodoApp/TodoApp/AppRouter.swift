//
//  AppRouter.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import Foundation
import UIKit
class AppRouter {
    func start(scene : UIWindowScene) -> UIWindow {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: MainViewBuilder.build())
        
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.windowScene = scene
        window.makeKeyAndVisible()
        return window
    }
}
