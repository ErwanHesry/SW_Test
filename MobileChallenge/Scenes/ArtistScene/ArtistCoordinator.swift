//
//  ArtistCoordinator.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 12/03/2021.
//

import UIKit
import Apollo

class ArtistCoordinator:Coordinator {
    // MARK: - Properties
    let networkService: NetworkService
    let navigationController: UINavigationController
    let storyboard = UIStoryboard.init(name: "Artist", bundle: nil)
    var delegate: CoordinatorDelegate? = nil
    
    init(navigationController: UINavigationController, networkService:NetworkService) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    // MARK: - Coordinator overrides
    override func start() {
        self.finish()
    }
    
    func startWith(_ artistId:String, artistName:String) {
        let artistVC: ArtistViewController = storyboard.instantiateInitialViewController() as! ArtistViewController
        let viewModel = ArtistViewModel.init(networkService: networkService)
        viewModel.artistId = artistId
        viewModel.artistName = artistName
        viewModel.coordinatorDelegate = self
        artistVC.viewModel = viewModel
        self.navigationController.pushViewController(artistVC, animated: true)
    }
    
    override func finish() {
        self.delegate?.didFinish(from: self)
    }
}

extension ArtistCoordinator:ArtistViewModelCoordinatorDelegate {
    func onCloseArtist() {
        self.navigationController.popViewController(animated: true)
        self.finish()
    }
}
