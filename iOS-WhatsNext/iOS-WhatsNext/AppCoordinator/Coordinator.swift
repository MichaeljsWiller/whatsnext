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
        mainViewModel.coordinator = self
        mainVc.viewModel = mainViewModel
        navigationController.pushViewController(mainVc, animated: true)
    }
    
    func navigateToShoppingView() {
        let shoppingListVc = ShoppingListView()
        let shoppingListViewModel = ShoppingListViewModel()
        shoppingListViewModel.coordinator = self
        shoppingListViewModel.delegate = shoppingListVc
        shoppingListVc.viewModel = shoppingListViewModel
        navigationController.pushViewController(shoppingListVc, animated: true)
    }
    
    func openMenu(viewModel: ShoppingListViewModel) {
        let menuVc = MenuView()
        let menuVm = MenuViewModel()
        menuVm.shoppingListVM = viewModel
        menuVc.viewModel = menuVm
        menuVm.coordinator = self
        if let currentView = navigationController.visibleViewController as? ShoppingListView {
            menuVc.modalPresentationStyle = .custom
            menuVc.transitioningDelegate = currentView
            currentView.present(menuVc, animated: true, completion: nil)
        }
    }
    
    func dismissMenu() {
        navigationController.dismiss(animated: true)
    }
    
    
    /// Displays an alert on the screen with the option to configure the alert with a TextField
    /// - Parameters:
    ///   - title: The title for the alert
    ///   - message: The message the alert will show
    ///   - actionTitle: The title for the action button
    ///   - configuration: Optional to configure an added text field
    ///   - completion: action to perform when the alert button has been pressed
    func showAlertWith(title: String?,
                       message: String?,
                       actionTitle: String?,
                       configuration: ((UITextField) -> Void)?,
                       completion: ((String?) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textfield: UITextField) in
            if let configuration = configuration {
                configuration(textfield)
            }
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { _ in
            if let textField = alert.textFields?.first,
               let item = textField.text {
                if let completion = completion {
                    completion(item)
                }
            }
        }))
        navigationController.visibleViewController?.present(alert, animated: true)
    }
}

