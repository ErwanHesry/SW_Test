//
//  BookmarksViewController.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 12/03/2021.
//

import UIKit

class BookmarksViewController: UIViewController {
    // MARK: - Properties
    var viewModel: BookmarksViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refreshArtists()
    }
}

// MARK: - ViewModelView Delegate
extension BookmarksViewController: BookmarksViewModelViewDelegate {
    func updateScreen() {
        if viewModel?.artists.count == 0 {
            self.navigationItem.title = "noBookmark".localize("Bookmarks")
        } else {
            self.navigationItem.title = "bookmarks".localizeWithFormat(inTable: "Bookmarks", viewModel?.artists.count ?? 0)
        }
        self.listTableView.reloadData()
    }
}

// MARK: - UITableView Delegates
extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookmarkAction = UIContextualAction.init(style:.destructive, title: "removeBookmark".localize("Bookmarks")) { (action, sourceView, completionHandler) in
            self.viewModel?.manageBookmarkForArtistAt(indexPath)
        }
        let configuration = UISwipeActionsConfiguration.init(actions: [bookmarkAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.goToArtistAt(indexPath)
    }
}

extension BookmarksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.artists.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
        viewModel?.setup(cell, at: indexPath)
        return cell
    }
    
}

