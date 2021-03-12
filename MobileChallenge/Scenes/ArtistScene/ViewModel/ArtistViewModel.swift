//
//  ArtistViewModel.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 12/03/2021.
//

import Foundation

protocol ArtistViewModelType {
    var viewDelegate: ArtistViewModelViewDelegate? { get set }
    var artist:ArtistQuery.Data.Node.AsArtist? { get set }
    var artistName: String? { get set }
    var bookmarks:[String:String] { get set }
    
    func isAbookmarkArtist() -> Bool
    func manageArtistBookmark()
    func onCloseArtist()
}

protocol ArtistViewModelCoordinatorDelegate {
    func onCloseArtist()
}

protocol ArtistViewModelViewDelegate {
    func updateScreen()
}

class ArtistViewModel:ViewModel {
    var coordinatorDelegate: ArtistViewModelCoordinatorDelegate?
    var viewDelegate: ArtistViewModelViewDelegate?
    var artist:ArtistQuery.Data.Node.AsArtist?
    private var artistIdentifier: String?
    var artistId: String? {
        get {
            return self.artistIdentifier
        }
        set {
            self.artistIdentifier = newValue
            if let artistIdentifier = self.artistIdentifier {
                networkService.getArtist(artistIdentifier) { (artist, error) in
                    self.artist = artist
                    self.viewDelegate?.updateScreen()
                }
            }
        }
    }
    var artistName: String?
    var bookmarks = [String:String]()
    
    override init(networkService: NetworkService) {
        super.init(networkService: networkService)
        bookmarks = self.getBookmarks()
    }
}

extension ArtistViewModel: ArtistViewModelType {
    func isAbookmarkArtist() -> Bool {
        if let artistId = artistIdentifier {
            return bookmarks[artistId] != nil
        }
        return false
    }
    
    func manageArtistBookmark() {
        if let artistId = artistIdentifier, let artistName = artistName {
            if self.isAbookmarkArtist() {
                bookmarks.removeValue(forKey: artistId)
            } else {
                bookmarks[artistId] = artistName
            }
        }
        self.setBookmarks(bookmarks)
        viewDelegate?.updateScreen()
    }
    
    func onCloseArtist() {
        coordinatorDelegate?.onCloseArtist()
    }
}
