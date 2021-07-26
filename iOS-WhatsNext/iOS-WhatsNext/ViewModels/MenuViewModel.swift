//
//  MenuViewModel.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 26/07/2021.
//

import UIKit

class MenuViewModel {
    
    /// Controls navigation between views
    weak var coordinator: AppCoordinator?
    
    /// Closes the menu
    func closeMenu() {
        coordinator?.dismissMenu()
    }
}
