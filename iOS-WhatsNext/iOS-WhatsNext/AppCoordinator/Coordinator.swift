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

class AppCoordinator: Coordinator {
    let window: UIWindow
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let splashScreenVc = SplashScreenVC()
        navigationController.pushViewController(splashScreenVc, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        splashScreenVc.coordinator = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func splashCompleted() {
        showMain()
    }

    func showMain() {
        let mainVc = MainView()
        let mainViewModel = MainViewModel()
        mainVc.coordinator = self
        mainVc.viewModel = mainViewModel
        navigationController.pushViewController(mainVc, animated: true)
    }
    
    func navigateToShoppingView() {
        let shoppingListVc = ShoppingListView()
        let shoppingListViewModel = ShoppingListViewModel()
        shoppingListVc.coordinator = self
        shoppingListVc.viewModel = shoppingListViewModel
        navigationController.pushViewController(shoppingListVc, animated: true)
    }
}

