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
        let rename = MenuItem(name: "Rename") { [weak self] in
            self?.shoppingListVM?.renameList()
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
