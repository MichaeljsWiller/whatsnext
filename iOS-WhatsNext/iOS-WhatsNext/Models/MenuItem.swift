//
//  MenuItem.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 26/07/2021.
//

import Foundation

class MenuItem {
    
    /// The name of the menu item
    let name: String
    /// The action to perform when the menu item is selected
    let action: () -> Void
    
    init(name: String, action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
}
