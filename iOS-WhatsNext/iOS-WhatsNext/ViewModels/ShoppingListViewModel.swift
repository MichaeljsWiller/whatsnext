//
//  ShoppingListViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 10/01/2021.
//

import UIKit

protocol ShoppingListItemDelegate: AnyObject {
    /// Notifies listeners that the items in the shopping list have changed
    func listHasChanged()
}

/// ViewModel backing the shopping list view
class ShoppingListViewModel: ShoppingListDelegate {
    
    weak var delegate: ShoppingListItemDelegate?
    /// Controls navigation between views
    weak var coordinator: AppCoordinator?
    /// the list that is currently being viewed
    @Published var currentList: ShoppingList
    
    init(currentList: ShoppingList = ShoppingList(title: "New List", items: [], itemsInBasket: [])) {
        self.currentList = currentList
    }
    
    /// Adds a new item to the shopping list
    func addNewItem(item: String) {
        guard !item.isEmpty else { return }
        let newItem = Item(name: item, price: 0)
        currentList.items.append(newItem)
        delegate?.listHasChanged()
    }
    
    /// Moves an item in the basket back into the main list
    func undoItemMove(at indexPath: IndexPath) {
        let selectedItem = currentList.itemsInBasket[indexPath.row]
        currentList.itemsInBasket.remove(at: indexPath.row)
        let undoItem = Item(name: selectedItem.name, price: selectedItem.price)
        currentList.items.append(undoItem)
        delegate?.listHasChanged()
    }
    
    /// Action for when the add new item button is tapped
    @objc func didTapButton() {
        coordinator?.showAlertWith(title: "New Item",
                                   message: "Enter a new Item",
                                   actionTitle: "Add",
                                   configuration: nil,
                                   completion: { item in
                                    guard let item = item else { return }
                                    self.addNewItem(item: item)
                                   })
    }
    
    /// Edits the name of the item selected in the list
    func editItem(indexPath: IndexPath) {
        coordinator?.showAlertWith(
            title: "Edit Item",
            message: nil,
            actionTitle: "Done",
            configuration: { textField in
                textField.text = self.currentList.items[indexPath.row].name
            },
            completion: { [weak self] item in
                guard let item = item else { return }
                if !item.isEmpty {
                    self?.currentList.items[indexPath.row].name = item
                    self?.delegate?.listHasChanged()
                }
            })
    }
    
    /// Moves the item in the cell at the index path to a different section
    func moveItemToBasket(from indexPath: IndexPath) {
        let currentItem = currentList.items[indexPath.row]
        currentList.items.remove(at: indexPath.row)
        let newItemInBasket = ItemInBasket(name: currentItem.name, price: currentItem.price)
        currentList.itemsInBasket.append(newItemInBasket)
        delegate?.listHasChanged()
    }
}
