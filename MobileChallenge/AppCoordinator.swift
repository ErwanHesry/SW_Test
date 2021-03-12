//
//  AppCoordinator.swift
//
//  Created by Erwan Hesry on 22/06/2020.
//  Copyright © 2020 Erwan Hesry. All rights reserved.
//

import UIKit

class AppCoordinator : Coordinator {
    // MARK: - Properties
    let window: UIWindow?
    
    let networkService : NetworkService = {
        let env = Bundle.main.infoDictionary!
        return NetworkService(baseUrl: env["GRAPHQL_API_URL"] as! String)
    }()
    
    lazy var searchRootViewController: UINavigationController = {
        var nvc = UINavigationController(rootViewController: UIViewController())
        nvc.navigationBar.prefersLargeTitles = true
        return nvc
    }()
    
    lazy var bookmarksRootViewController: UINavigationController = {
        var nvc = UINavigationController(rootViewController: UIViewController())
        nvc.navigationBar.prefersLargeTitles = true
        return nvc
    }()
    
    lazy var rootViewController: UITabBarController = {
        var tabBarController = UITabBarController()
        tabBarController.viewControllers=[searchRootViewController, bookmarksRootViewController]
        return tabBarController
    }()
    
    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: - Coordinator overrides
    override func start() {
        guard let window = window else {
            return
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let searchCoordinator = SearchCoordinator(rootViewController: searchRootViewController, networkService: networkService)
        searchCoordinator.delegate = self
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        let bookmarksCoordinator = BookmarksCoordinator(rootViewController: bookmarksRootViewController, networkService: networkService)
        bookmarksCoordinator.delegate = self
        addChildCoordinator(bookmarksCoordinator)
        bookmarksCoordinator.start()
    }
}

// MARK: - Coordinator Callback's
extension AppCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
