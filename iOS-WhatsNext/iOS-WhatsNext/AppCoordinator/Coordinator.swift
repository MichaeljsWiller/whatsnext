//
//  Coordinator.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 08/11/2020.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator, SplashScreenDelegate {
    let window: UIWindow
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = SplashScreenVC()
        navigationController.pushViewController(vc, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        vc.delegate = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func splashCompleted() {
        showMain()
    }

    func showMain() {
        let view = MainView()
        navigationController.pushViewController(view, animated: false)
    }
}

