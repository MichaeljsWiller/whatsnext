//
//  ShoppingList+CoreDataProperties.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 26/09/2021.
//
//

import Foundation
import CoreData


extension ShoppingList {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
    return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
  }
  
  /// The title of the list
  @NSManaged public var title: String
  /// The items within the lists
  @NSManaged public var items: NSSet?
  
  /// A list of items that have yet to be placed in the basket
  public var itemsArray: [ShoppingListItem] {
    let set = items as? Set<ShoppingListItem> ?? []
    let array = set.sorted { $0.name < $1.name }
    return array.filter { $0.inBasket == false }
  }
  
  /// A list of items currently in the users basket
  public var itemsInBasket: [ShoppingListItem] {
    let set = items as? Set<ShoppingListItem> ?? []
    let array = set.sorted { $0.name < $1.name }
    return array.filter { $0.inBasket == true }
  }
}
  // MARK: Generated accessors for items
  extension ShoppingList {
    
    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ShoppingListItem)
    
    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ShoppingListItem)
    
    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)
    
    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)
    
  }
  
  extension ShoppingList : Identifiable {
    
  }
