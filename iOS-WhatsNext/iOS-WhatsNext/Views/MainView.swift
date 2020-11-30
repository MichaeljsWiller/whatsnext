//
//  MainView.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 11/11/2020.
//

import UIKit

class MainView: UIViewController {
    weak var delegate: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}
