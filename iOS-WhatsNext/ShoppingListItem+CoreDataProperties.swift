//
//  ShoppingListItem+CoreDataProperties.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 26/09/2021.
//
//

import Foundation
import CoreData


extension ShoppingListItem {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingListItem> {
    return NSFetchRequest<ShoppingListItem>(entityName: "ShoppingListItem")
  }
  
  /// The name of the item
  @NSManaged public var name: String
  /// The price of the item
  @NSManaged public var price: Float
  /// Whether the item is currently in the users basket
  @NSManaged public var inBasket: Bool
  /// The shopping list this item belongs to
  @NSManaged public var origin: ShoppingList
  
}

extension ShoppingListItem : Identifiable {
  
}
