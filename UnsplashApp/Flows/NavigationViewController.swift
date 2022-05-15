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
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false

        let app = UINavigationBarAppearance()
        
        app.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
        app.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
        app.backgroundColor = .white
        self.navigationBar.compactAppearance = app
        self.navigationBar.standardAppearance = app
        self.navigationBar.scrollEdgeAppearance = app
        
        self.navigationBar.prefersLargeTitles = true
    }
}
