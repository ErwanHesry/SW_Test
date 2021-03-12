//
//  BookmarksViewModel.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 12/03/2021.
//

import UIKit

protocol BookmarksViewModelType {
    var viewDelegate: BookmarksViewModelViewDelegate? { get set }
    
    var artists:[String:String] { get set }
    func refreshArtists()
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath)
    func manageBookmarkForArtistAt(_ indexPath: IndexPath)
    func goToArtistAt(_ indexPath:IndexPath)
}

protocol BookmarksViewModelCoordinatorDelegate {
    func goToArtist(_ artistId:String, _ artistName:String)
}

protocol BookmarksViewModelViewDelegate {
    func updateScreen()
}

class BookmarksViewModel:ViewModel {
    var coordinatorDelegate: BookmarksViewModelCoordinatorDelegate?
    var viewDelegate: BookmarksViewModelViewDelegate?
    var artists = [String:String]()
    
    override init(networkService: NetworkService) {
        super.init(networkService: networkService)
        artists = self.getBookmarks()
    }
}

extension BookmarksViewModel: BookmarksViewModelType {
    func refreshArtists() {
        self.artists = self.getBookmarks()
        self.viewDelegate?.updateScreen()
    }
    
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let artistId = Array(self.artists.keys)[indexPath.section]
        let artistName = self.artists[artistId]
        cell.textLabel?.text = artistName
    }
    
    func manageBookmarkForArtistAt(_ indexPath: IndexPath) {
        let artistId = Array(self.artists.keys)[indexPath.section]
        self.artists.removeValue(forKey: artistId)
        self.setBookmarks(self.artists)
        self.viewDelegate?.updateScreen()
    }
    
    func goToArtistAt(_ indexPath: IndexPath) {
        let artistId = Array(self.artists.keys)[indexPath.section]
        let artistName = self.artists[artistId]
        coordinatorDelegate?.goToArtist(artistId, artistName ?? "")
    }
}
