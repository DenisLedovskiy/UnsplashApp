//
//  ViewController.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarViewControiller()
    }

    func configureTabBarViewControiller() {

        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem

        let homeVC = HomeViewController()
        let favouriteVC = FavouriteViewController()

        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemPink

        homeVC.title = "Home"
        favouriteVC.title = "Favourite"

        self.setViewControllers([homeVC, favouriteVC], animated: false)

        guard let items = self.tabBar.items else {return}

        let images = ["house", "heart"]

        for i in 0...1 {
            items[i].image = UIImage(systemName: images[i])
        }
    }
}


