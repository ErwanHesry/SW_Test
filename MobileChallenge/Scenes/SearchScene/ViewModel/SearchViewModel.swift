//
//  SearchViewModel.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 10/03/2021.
//

import UIKit

protocol SearchViewModelType {
    var viewDelegate: SearchViewModelViewDelegate? { get set }
    
    var artists:[ArtistsQuery.Data.Search.Artist.Node] { get set }
    var isSearching:Bool {get set}
    func loadMoreArtistsFor(_ artist:String)
    func searchFor(_ artist:String, reset: Bool)
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath)
    func manageBookmarkForArtistAt(_ indexPath: IndexPath)
    func isAbookmarkArtistAt(_ indexPath: IndexPath) -> Bool
    func goToArtistAt(_ indexPath:IndexPath)
}

protocol SearchViewModelCoordinatorDelegate {
    func goToArtist(_ artistId:String, _ artistName:String)
}

protocol SearchViewModelViewDelegate {
    func updateScreen()
    func updateRowAt(_ indexPath:IndexPath)
}

class SearchViewModel:ViewModel {
    var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    var viewDelegate: SearchViewModelViewDelegate?
    var artists = [ArtistsQuery.Data.Search.Artist.Node]()
    var isSearching:Bool = false
}

extension SearchViewModel: SearchViewModelType {
    func loadMoreArtistsFor(_ artist: String) {
        if !isSearching {
            self.searchFor(artist, reset: false)
        }
    }
    
    func searchFor(_ artist: String, reset: Bool) {
        debounce(delay: 0.3) {
            self.isSearching = true
            self.networkService.searchFor(artist, first: 15, after: reset ? nil : self.artists.last?.id ?? nil) { (artistsNodes, error) in
                if let artists = artistsNodes {
                    if reset {
                        self.artists = []
                    }
                    self.artists.append(contentsOf: artists)
                }
                self.isSearching = false
                DispatchQueue.main.async {
                    self.viewDelegate?.updateScreen()
                }
            }
        }
    }
    
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let artist = self.artists[indexPath.section]
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.disambiguation
    }
    
    func manageBookmarkForArtistAt(_ indexPath: IndexPath) {
        var bookmarks = self.getBookmarks()
        let artist = self.artists[indexPath.section]
        if self.isAbookmarkArtistAt(indexPath) {
            bookmarks.removeValue(forKey: artist.id)
        } else {
            bookmarks[artist.id] = artist.name
        }
        self.setBookmarks(bookmarks)
        self.viewDelegate?.updateRowAt(indexPath)
    }
    
    func isAbookmarkArtistAt(_ indexPath: IndexPath) -> Bool {
        let bookmarks = self.getBookmarks()
        let artist = self.artists[indexPath.section]
        return bookmarks[artist.id] != nil
    }
    
    func goToArtistAt(_ indexPath: IndexPath) {
        let artist = self.artists[indexPath.section]
        coordinatorDelegate?.goToArtist(artist.id, artist.name ?? "")
    }
}
