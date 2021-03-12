//
//  BookmarksCoordinator.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 10/03/2021.
//

import UIKit

class BookmarksCoordinator:Coordinator {
    // MARK: - Properties
    let networkService: NetworkService
    let rootViewController: UINavigationController
    let storyboard = UIStoryboard.init(name: "Bookmarks", bundle: nil)
    var delegate: CoordinatorDelegate? = nil
    
    init(rootViewController: UINavigationController, networkService:NetworkService) {
        self.networkService = networkService
        
        self.rootViewController = rootViewController
        self.rootViewController.tabBarItem.image = UIImage(systemName: "book.circle")
        self.rootViewController.tabBarItem.selectedImage = UIImage(systemName: "book.circle.fill")
        self.rootViewController.tabBarItem.title = "tabBarItem".localize("Bookmarks")
    }
    
    // MARK: - Coordinator overrides
    override func start() {
        let bookmarksVC: BookmarksViewController = storyboard.instantiateInitialViewController() as! BookmarksViewController
        let viewModel = BookmarksViewModel(networkService: self.networkService)
        viewModel.coordinatorDelegate = self
        bookmarksVC.viewModel = viewModel
        self.rootViewController.viewControllers=[bookmarksVC]
    }
    
    override func finish() {
        self.delegate?.didFinish(from: self)
    }
}

extension BookmarksCoordinator: BookmarksViewModelCoordinatorDelegate {
    func goToArtist(_ artistId: String, _ artistName: String) {
        let artistCoordinator = ArtistCoordinator.init(navigationController: self.rootViewController, networkService: self.networkService)
        artistCoordinator.delegate = self
        addChildCoordinator(artistCoordinator)
        artistCoordinator.startWith(artistId, artistName: artistName)
    }
}

extension BookmarksCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
