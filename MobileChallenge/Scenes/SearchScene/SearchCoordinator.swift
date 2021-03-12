//
//  SearchSceneCoordinator.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 10/03/2021.
//

import UIKit
import Apollo

class SearchCoordinator:Coordinator {
    // MARK: - Properties
    let networkService: NetworkService
    let rootViewController: UINavigationController
    let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
    var delegate: CoordinatorDelegate? = nil
    
    init(rootViewController: UINavigationController, networkService:NetworkService) {
        self.networkService = networkService
        
        self.rootViewController = rootViewController
        self.rootViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        self.rootViewController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        self.rootViewController.tabBarItem.title = "tabBarItem".localize("Search")
    }
    
    // MARK: - Coordinator overrides
    override func start() {
        let searchVC: SearchListViewController = storyboard.instantiateInitialViewController() as! SearchListViewController
        let viewModel = SearchViewModel(networkService: self.networkService)
        viewModel.coordinatorDelegate = self
        searchVC.viewModel = viewModel
        self.rootViewController.viewControllers=[searchVC]
    }
    
    override func finish() {
        self.delegate?.didFinish(from: self)
    }
}

extension SearchCoordinator: SearchViewModelCoordinatorDelegate {
    func goToArtist(_ artistId: String, _ artistName: String) {
        let artistCoordinator = ArtistCoordinator.init(navigationController: self.rootViewController, networkService: self.networkService)
        artistCoordinator.delegate = self
        addChildCoordinator(artistCoordinator)
        artistCoordinator.startWith(artistId, artistName: artistName)
    }
}

extension SearchCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
