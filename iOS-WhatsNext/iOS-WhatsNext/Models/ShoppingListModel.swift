//
//  ShoppingListModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 10/01/2021.
//

import Foundation

/// Represents a shopping list containing items
class ShoppingList {
    /// The title of the shopping list
    var title: String
    /// A list of items in the shopping list
    var items: [Item]
    /// A list of items that have been ticked off
    var itemsInBasket: [ItemInBasket]
    
    init(title: String, items: [Item], itemsInBasket: [ItemInBasket]) {
        self.title = title
        self.items = items
        self.itemsInBasket = itemsInBasket
    }
}

/// Represents an item in a shopping list
struct Item {
    /// The name of an item in a shopping list
    var name: String
    /// The price of an item
    var price: Float
}

/// Represents an item on a shopping list that is in the basket
struct ItemInBasket {
    /// The name of an item in a shopping list
    var name: String
    /// The price of an item
    var price: Float
}
