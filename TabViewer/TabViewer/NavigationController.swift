//
//  NavigationController.swift
//  TabViewer
//
//  Created by Cédric Bahirwe on 09/04/2021.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .gray
        
    }
}
