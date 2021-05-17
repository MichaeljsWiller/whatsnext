//
//  ShoppingListViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 10/01/2021.
//

import UIKit

class ShoppingListViewModel {
    /// the list that is currently being viewed
    var currentList: ShoppingList = ShoppingList(title: "test", items: [], tickedItems: [])
    /// The items stored in the list
    var items: [String] = []
    
    func addNewItem(item: String) {
        let newItem = Item(name: item, price: 0)
        currentList.items.append(newItem)
        //items.append(item)
    }

}
