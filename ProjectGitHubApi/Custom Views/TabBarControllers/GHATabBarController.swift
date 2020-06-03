//
//  GHATabBarController.swift
//  ProjectGitHubApi
//
//  Created by Leonardo Maia Pugliese on 02/06/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class GHATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(),createFavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search , tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites , tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
