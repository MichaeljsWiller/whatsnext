//
//  ViewHelper.swift
//  iOS-WhatsNextTests
//
//  Created by Michael Willer on 29/08/2021.
//

import XCTest
@testable import iOS_WhatsNext

class ViewHelper {
    
    static func loadView(from coordinator: AppCoordinator) {
        let keyWinow = UIApplication.shared.windows.first(where: \.isKeyWindow)
        keyWinow?.rootViewController = coordinator.navigationController
        coordinator.window.rootViewController = keyWinow?.rootViewController
        coordinator.navigateToShoppingView()
        coordinator.navigationController.visibleViewController?.loadViewIfNeeded()
        XCTAssertEqual(coordinator.navigationController.visibleViewController?.isViewLoaded, true)
    }
}
