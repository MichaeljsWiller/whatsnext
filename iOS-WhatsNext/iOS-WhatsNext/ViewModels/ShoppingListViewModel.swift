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
  
  init(currentList: ShoppingList) {
    self.currentList = currentList
  }
  
  /// Adds a new item to the shopping list
  func addNewItem(item: String) {
    guard !item.isEmpty else { return }
    let newItem = ShoppingListItem(context: context)
    newItem.name = item
    newItem.price = 0
    newItem.inBasket = false
    newItem.origin = currentList
    
    //currentList.addToItems(newItem)
    saveList()
    delegate?.listHasChanged()
  }
  
  /// Moves an item in the basket back into the main list
  func undoItemMove(at indexPath: IndexPath) {
    let selectedItem = currentList.itemsInBasket[indexPath.row]
    selectedItem.inBasket = false
    saveList()
    delegate?.listHasChanged()
  }
  
  /// Edits the name of the item selected in the list
  func editItemName(at indexPath: IndexPath) {
    coordinator?.showAlertWith(
      title: "Edit Item",
      message: nil,
      actionTitle: "Done",
      configuration: { textField in
        textField.text = self.currentList.itemsArray[indexPath.row].name
      },
      completion: { [weak self] item in
        guard let item = item else { return }
        if !item.isEmpty {
          self?.currentList.itemsArray[indexPath.row].name = item
          self?.saveList()
          self?.delegate?.listHasChanged()
        }
      })
  }
  
  /// Moves the item in the cell at the index path to a different section
  func moveItemToBasket(from indexPath: IndexPath) {
    let currentItem = currentList.itemsArray[indexPath.row]
    currentItem.inBasket = true
    saveList()
    delegate?.listHasChanged()
  }
  
  /// Renames the current shopping list
  func renameList() {
    coordinator?.showAlertWith(
      title: "Rename",
      message: "Type the new name that you would like for this list.",
      actionTitle: "Rename",
      configuration: nil,
      completion: { name in
        guard let name = name else { return }
        if !name.isEmpty {
          self.currentList.title = name
          self.delegate?.listHasChanged()
          self.coordinator?.dismissMenu()
          self.saveList()
        }
      })
  }
  
  /// Opens the menu for the shopping list
  @objc func openMenu() {
    coordinator?.openMenu(viewModel: self)
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
  
  private func saveList() {
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
}
