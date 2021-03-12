//
//  NetworkService.swift
//  MobileChallenge
//
//  Created by Erwan Hesry on 10/03/2021.
//

import Foundation
import Network
import Apollo

class NetworkService {
    // MARK: - Properties
    var networkSatisfied = true
    let monitor = NWPathMonitor()
    let networkServiceMonitorQueue = DispatchQueue(label: "NetworkServiceMonitor")
    var apollo:ApolloClient
    
    // MARK: - Init & Private methods
    init(baseUrl:String) {
        self.apollo = ApolloClient(url: URL(string: baseUrl)!)
        self.startNetworkMonitoring()
    }
    
    private func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.networkSatisfied = path.status == .satisfied
        }
        
        monitor.start(queue: networkServiceMonitorQueue)
    }
    
    func searchFor(_ artist:String, first:Int, after:String?, completionHandler:@escaping (_ results:[ArtistsQuery.Data.Search.Artist.Node]?, _ error:Error?) -> Void) {
        guard self.networkSatisfied else {
            completionHandler(nil, self.networkServiceErrorFrom(.Disconnected))
            return
        }
        
        self.apollo.fetch(query: ArtistsQuery.init(search: artist, first: first, after: after)) { result in
            switch result {
              case .success(let graphQLResult):
                let artistNodes = graphQLResult.data?.search?.artists?.nodes?.compactMap { $0 }
                completionHandler(artistNodes, nil)
              case .failure(let error):
                completionHandler(nil, error)
              }
        }
    }
    
    func getArtist(_ artistIdentifier:String, completionHandler:@escaping (_ results:ArtistQuery.Data.Node.AsArtist?, _ error:Error?) -> Void) {
        guard self.networkSatisfied else {
            completionHandler(nil, self.networkServiceErrorFrom(.Disconnected))
            return
        }
        
        self.apollo.fetch(query: ArtistQuery.init(artistIdentifier: artistIdentifier)) { result in
            switch result {
              case .success(let graphQLResult):
                completionHandler(graphQLResult.data?.node?.asArtist, nil)
              case .failure(let error):
                completionHandler(nil, error)
              }
        }
    }
}

extension NetworkService {
    // MARK: - Service errors
    enum NetworkServiceError: Int {
        case Disconnected = 0
        case Other = 1
    }
    
    func getNetworkStatusError(nse: NetworkServiceError) -> String {
        switch nse {
        case .Disconnected:
            return "Disconnected"
        default:
            return "Other"
        }
    }
    
    func networkServiceErrorFrom(_ errorCode:NetworkServiceError) -> Error {
        return NSError.init(domain: "NetworkService", code: errorCode.rawValue, userInfo: ["Message" : self.getNetworkStatusError(nse: errorCode)])
    }
}
