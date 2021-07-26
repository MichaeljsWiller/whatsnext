//
//  MenuViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 26/07/2021.
//

import UIKit

class MenuViewModel {
    
    /// Controls navigation between views
    weak var coordinator: AppCoordinator?
    /// The viewModel used to modify the current shopping list
    weak var shoppingListVM: ShoppingListViewModel?
    /// A list of menu items that perform different actions
    private(set) var menuItems: [MenuItem] = []
    
    init() {
        populate()
    }
    
    /// Closes the menu
    func closeMenu() {
        coordinator?.dismissMenu()
    }
    
    /// Populates the menu with menu items
    func populate() {
        let rename = MenuItem(name: "Rename") {
            self.coordinator?.showAlertWith(
                title: "Rename",
                message: "Type the new name that you would like for this list.",
                actionTitle: "Rename",
                configuration: nil,
                completion: { name in
                    guard let name = name else { return }
                    if !name.isEmpty {
                        self.shoppingListVM?.currentList.title = name
                        self.shoppingListVM?.delegate?.listHasChanged()
                    }
                })
            self.shoppingListVM?.currentList.title = "hello"
        }
        menuItems.append(rename)
        
        let newList = MenuItem(name: "Create New List") {
            print("Not implemented yet")
        }
        menuItems.append(newList)
        
        let save = MenuItem(name: "Save List") {
            print("Not implemented yet")
        }
        menuItems.append(save)
        
        let delete = MenuItem(name: "Delete List") {
            print("Not implemented yet")
        }
        menuItems.append(delete)
    }
}
