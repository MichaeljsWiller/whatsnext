//
//  ShoppingListViewModelTests.swift
//  iOS-WhatsNextTests
//
//  Created by Michael Willer on 14/08/2021.
//

import XCTest
@testable import iOS_WhatsNext

class ShoppingListViewModelTests: XCTestCase {
    
    var viewModel: ShoppingListViewModel?
    var coordinator: AppCoordinator?
    var window: UIWindow?

    override func setUp() {
        viewModel = ShoppingListViewModel()
        window = UIWindow()
        coordinator = AppCoordinator(window: window!)
        viewModel?.coordinator = coordinator
    }

    override func tearDown() {
        viewModel = nil
        window = nil
        coordinator = nil
        
    }

    func testNewItemIsAddedToListWhenUserSelectsToAddAnItem() {
        guard let viewModel = viewModel else { return XCTFail() }
        let itemsInList = viewModel.currentList.items
        // Expect the list to be empty
        XCTAssertTrue(itemsInList.isEmpty)
        // When a user adds a new item to the list
        viewModel.addNewItem(item: "Apple")
        // Expect the number of items in the list to be increased by one
        XCTAssertTrue(viewModel.currentList.items.count == itemsInList.count + 1)
    }
    
    func testItemsInListMatchesTheItemsTheUserAdded() {
        guard let viewModel = viewModel else { return XCTFail() }
        // Expect the user to want to add items to a list
        var itemsToAdd: [String] = []
        let item1 = "Cookies"
        itemsToAdd.append(item1)
        let item2 = "Banana"
        itemsToAdd.append(item2)
        let item3 = "Cottage Pie"
        itemsToAdd.append(item3)
        let item4 = "Washing up liquid"
        itemsToAdd.append(item4)
        // When a user adds the items to the list
        for item in itemsToAdd {
            viewModel.addNewItem(item: item)
        }
        // Expect the list to contain all items added by the user
        XCTAssertTrue(viewModel.currentList.items.contains {$0.name == item1})
        XCTAssertTrue(viewModel.currentList.items.contains {$0.name == item2})
        XCTAssertTrue(viewModel.currentList.items.contains {$0.name == item3})
        XCTAssertTrue(viewModel.currentList.items.contains {$0.name == item4})
    }
