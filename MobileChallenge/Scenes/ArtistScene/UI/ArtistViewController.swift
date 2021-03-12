//
//  ArtistViewController.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 12/03/2021.
//

import UIKit

class ArtistViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ArtistViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    let favoriteButton = UIBarButtonItem.init(image: UIImage.init(systemName: "star"), style: .plain, target: self, action: #selector(onFavoriteButtonTouched))
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var disambiguation: UILabel!
    @IBOutlet weak var ratingVoteCount: UILabel!
    @IBOutlet weak var ratingValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = viewModel?.artistName
        
        if let vm = viewModel, vm.isAbookmarkArtist() {
            favoriteButton.image = UIImage.init(systemName: "star.fill")
        }
        favoriteButton.target = self
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.onCloseArtist()
    }
    
    @objc func onFavoriteButtonTouched() {
        viewModel?.manageArtistBookmark()
    }
}

extension ArtistViewController: ArtistViewModelViewDelegate {
    func updateScreen() {
        if let artist = viewModel?.artist {
            self.name.text = artist.name
            self.disambiguation.text = artist.disambiguation
            if let rating = artist.rating, let ratingValue = rating.value {
                self.ratingValue.text = "ratingValue".localizeWithFormat(inTable: "Artist", ratingValue)
                self.ratingVoteCount.text = "ratingCount".localizeWithFormat(inTable: "Artist", rating.voteCount)
            }
        }
        
        if let vm = viewModel {
            if vm.isAbookmarkArtist() {
                favoriteButton.image = UIImage.init(systemName: "star.fill")
            } else {
                favoriteButton.image = UIImage.init(systemName: "star")
            }
        }
    }
}
