//
//  ShoppingListViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 10/01/2021.
//

import UIKit

class ShoppingListViewModel {
    
    /// the list that is currently being viewed
    var currentList: ShoppingList
    /// The items stored in the list
    var items: [String] = []
    
    init(currentList: ShoppingList = ShoppingList(title: "New List", items: [], itemsInBasket: [])) {
        self.currentList = currentList
    }
    
    /// Adds a new item to the shopping list
    func addNewItem(item: String) {
        guard !item.isEmpty else { return }
        let newItem = Item(name: item, price: 0)
        currentList.items.append(newItem)
    }
    
    /// Moves an item in the shopping list to the in basket section
    func moveItemToBasket(from indexPath: IndexPath) {
        let currentItem = currentList.items[indexPath.row]
        currentList.items.remove(at: indexPath.row)
        let newItemInBasket = ItemInBasket(name: currentItem.name, price: currentItem.price)
        currentList.itemsInBasket.append(newItemInBasket)
    }
    
    /// Moves an item in the basket back into the main list
    func undoItemMove(at indexPath: IndexPath) {
        let selectedItem = currentList.itemsInBasket[indexPath.row]
        currentList.itemsInBasket.remove(at: indexPath.row)
        let undoItem = Item(name: selectedItem.name, price: selectedItem.price)
        currentList.items.append(undoItem)
    }
}
