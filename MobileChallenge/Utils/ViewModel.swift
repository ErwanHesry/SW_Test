//
//  ViewModel.swift
//
//  Created by Erwan Hesry on 11/03/2021.
//

import Foundation

class ViewModel {
    let networkService: NetworkService
    var debounce_timer:Timer?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getBookmarks() -> [String:String] {
        var bookmarks: [String:String] = [:]
        let env = Bundle.main.infoDictionary!
        if let userDefaultsBookmarks:[String:String] = UserDefaults.standard.object(forKey: env["kUserDefaults_BOOKMARKS"] as! String) as? [String : String] {
            bookmarks = userDefaultsBookmarks
        }
        return bookmarks
    }
    
    func setBookmarks(_ bookmarks:[String:String]) {
        let env = Bundle.main.infoDictionary!
        UserDefaults.standard.setValue(bookmarks, forKey: env["kUserDefaults_BOOKMARKS"] as! String)
    }
    
    func debounce( delay:TimeInterval, action: @escaping () -> Void) {
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}
