//
//  MainTabBarController.swift
//  MyPodcasts
//
//  Created by Richard Price on 01/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        UINavigationBar.appearance().prefersLargeTitles = true
        setupViewControllers()
    }
    
    //MARK:- Setup viewcontrollers
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateNavControllers(with: PodcastSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavControllers(with: ViewController(), title: "Favourites", image: #imageLiteral(resourceName: "favorites")),
            generateNavControllers(with: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    //MARK:- Helper Function
    fileprivate func generateNavControllers(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
