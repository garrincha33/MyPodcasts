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
        
        setupPlayerDetailsController()
        
        perform(#selector(maximizePlayerDetails), with: nil, afterDelay: 1)
    }
    
    //MARK:- Setup viewcontrollers
    @objc fileprivate func minimizePlayerDetails() {
        maximizedTopAnchorContraints.isActive = false
        minimizedTopAnchorContraints.isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc fileprivate func maximizePlayerDetails() {
        print("2222")
        maximizedTopAnchorContraints.isActive = true
        maximizedTopAnchorContraints.constant = 0
        minimizedTopAnchorContraints.isActive = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    var maximizedTopAnchorContraints: NSLayoutConstraint!
    var minimizedTopAnchorContraints: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsController() {
        let playerDetailsView = PlayerDetailsView.initFromNib()
        playerDetailsView.backgroundColor = .red
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorContraints = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorContraints.isActive = true
        minimizedTopAnchorContraints = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
//        minimizedTopAnchorContraints.isActive = true
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
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
