//
//  SearchListViewController.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 11/03/2021.
//

import UIKit

class SearchListViewController: UIViewController {
    // MARK: - Properties
    var viewModel: SearchViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var tryTip: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "empty-0".localize("Search")
        
        self.tryButton.setTitle("trySearch".localize("Search"), for: .normal)
        self.tryButton.layer.cornerRadius = 6
        self.tryButton.layer.borderWidth = 1
        self.tryButton.layer.borderColor = self.tryButton.tintColor.cgColor
        self.tryTip.text = "tryTip".localize("Search")
        
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    @IBAction func onTryButtonTouched(_ sender: Any) {
        self.navigationItem.searchController?.searchBar.text = "John Mayer"
    }
}

// MARK: - ViewModelView Delegate
extension SearchListViewController: SearchViewModelViewDelegate {
    func updateScreen() {
        if viewModel?.artists.count == 0 {
            let emptyStringNumber = Int.random(in: 0..<5)
            self.title = "empty-\(emptyStringNumber)".localize("Search")
            tryButton.isHidden = false
            tryTip.isHidden = false
        } else {
            self.title = "artists".localizeWithFormat(inTable: "Search", viewModel?.artists.count ?? 0)
            tryButton.isHidden = true
            tryTip.isHidden = true
        }
        self.listTableView.reloadData()
    }
    
    func updateRowAt(_ indexPath: IndexPath) {
        self.listTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UISearchControllerDelegates
extension SearchListViewController: UISearchControllerDelegate {
    
}

extension SearchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            viewModel?.searchFor(searchText, reset: true)
        }
    }
}

// MARK: - UIScrollView Delegate
extension SearchListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel?.artists.count ?? 0 > 0 && scrollView.contentSize.height - scrollView.contentOffset.y < 750 + UIScreen.main.bounds.size.height, let searchText = self.navigationItem.searchController?.searchBar.text  {
            viewModel?.loadMoreArtistsFor(searchText)
        }
    }
}

// MARK: - UITableView Delegates
extension SearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isABookmark = viewModel?.isAbookmarkArtistAt(indexPath) ?? false
        
        let bookmarkAction = UIContextualAction.init(style: isABookmark ? .destructive : .normal, title: isABookmark ? "removeBookmark".localize("Search") : "addBookmark".localize("Search")) { (action, sourceView, completionHandler) in
            self.viewModel?.manageBookmarkForArtistAt(indexPath)
        }
        if bookmarkAction.style == .normal {
            bookmarkAction.backgroundColor = self.tryButton.tintColor
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

extension SearchListViewController: UITableViewDataSource {
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
