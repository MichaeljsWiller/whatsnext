//
//  ShoppingListModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 10/01/2021.
//

import Foundation

class ShoppingList {
    /// The title of the shopping list
    var title: String
    /// A list of items in the shopping list
    var items: [Item]
    /// A list of items that have been ticked off
    var tickedItems: [TickedItem]
    
    init(title: String, items: [Item], tickedItems: [TickedItem]) {
        self.title = title
        self.items = items
        self.tickedItems = tickedItems
    }
}

struct Item {
    /// The name of an item in a shopping list
    var name: String
    /// The price of an item
    var price: Float
}

struct TickedItem {
    /// The name of an item in a shopping list
    var name: String
    /// The price of an item
    var price: Float
}
