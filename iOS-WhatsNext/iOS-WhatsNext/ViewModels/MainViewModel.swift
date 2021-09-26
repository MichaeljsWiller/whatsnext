//
//  MainViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 17/12/2020.
//

import Foundation

class MainViewModel {
    weak var coordinator: AppCoordinator?
    var savedLists: [ShoppingList] = []
  
  init() {
    LoadSavedLists()
  }
  func createNewList() -> ShoppingList {
    let newList = ShoppingList(context: context)
    newList.title = "New List"
    newList.items = []
    
    do {
      try context.save()
    } catch {
      print(error)
    }
    
    return newList
  }
  
  func LoadSavedLists() {
    do {
      let lists: [ShoppingList] = try context.fetch(ShoppingList.fetchRequest())
      savedLists = lists
    } catch {
      print(error)
    }
  }
}
