//
//  NavigationViewController.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationViewController()
    }

    private func configureNavigationViewController() {
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.isTranslucent = false
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
