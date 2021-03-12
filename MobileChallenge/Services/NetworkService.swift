//
//  NetworkService.swift
//  BlaBlaTrip
//
//  Created by Erwan Hesry on 22/06/2020.
//  Copyright © 2020 Erwan Hesry. All rights reserved.
//

import UIKit
import Network

class NetworkService {
    // MARK: - Properties
    var baseUrl: String
    var networkSatisfied = true
    let monitor = NWPathMonitor()
    let networkServiceMonitorQueue = DispatchQueue(label: "NetworkServiceMonitor")
    
    // MARK: - Init & Private methods
    init(url:String) {
        baseUrl = url
        self.startNetworkMonitoring()
    }
    
    private func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.networkSatisfied = path.status == .satisfied
        }
        
        monitor.start(queue: networkServiceMonitorQueue)
    }
    
    func performNetwork(url:String, method:String, headers:[String:String]?, data:[String:Any]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        if networkSatisfied {
            guard let urlRequest = URL.init(string: url) else {
                completionHandler(nil, NetworkServiceError.InvalidUrl.rawValue)
                return
            }
            
            var request = URLRequest.init(url: urlRequest, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            request.httpMethod = method
            
            if let hdrs = headers {
                if hdrs.count > 0 {
                    for header in hdrs.keys {
                        request.setValue(hdrs[header], forHTTPHeaderField: header)
                    }
                }
            }
            
            if let dt = data {
                if dt.count > 0 {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dt, options: .prettyPrinted)
                        request.httpBody = jsonData
                    } catch {
                        print("Json encode error \(error)")
                    }
                }
            }
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.configuration.httpCookieStorage = HTTPCookieStorage.shared
            session.configuration.httpAdditionalHeaders = headers
            session.configuration.timeoutIntervalForRequest = 15
            session.configuration.timeoutIntervalForResource = 30
            
#if DEBUG
            print("---------------------------------- NetworkService - request ----------------------------------")
            print("url: \(url)")
            print("method: \(method)")
            print("headers:")
            print(headers ?? "none")
            print("data:")
            print(data ?? "none")
            print("\n\n")
#endif
            
            let urlDataTask = session.dataTask(with: request) { (data, response, error) in
#if DEBUG
                print("---------------------------------- NetworkService - response ----------------------------------")
                print("url: \(url)")
#endif
                if let httpResponse:HTTPURLResponse = response as? HTTPURLResponse {
#if DEBUG
                    print(httpResponse.statusCode)
#endif
                    if httpResponse.statusCode == 200 {
                        completionHandler(data, nil)
                    } else if 400 ... 500 ~= httpResponse.statusCode {
                        let statusError = NetworkStatusError.init(rawValue: httpResponse.statusCode)
                        completionHandler(data, self.getNetworkStatusError(nse: statusError!))
                    } else {
                        let statusError = NetworkStatusError.init(rawValue: -1)
                        completionHandler(data, self.getNetworkStatusError(nse: statusError!))
                    }
                } else {
                    completionHandler(data, self.getNetworkStatusError(nse: .Other))
                }
#if DEBUG
                print("\n\n")
#endif
            }
            urlDataTask.resume()
        } else {
            completionHandler(nil, NetworkServiceError.Disconnected.rawValue)
        }
    }
    
    // MARK: - Network calls
    func get(endPoint:String, headers:[String:String]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        self.performNetwork(url: baseUrl+endPoint, method: "GET", headers: headers, data: nil, completionHandler: completionHandler)
    }
    
    func post(endPoint:String, headers:[String:String]?, data:[String:Any]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        self.performNetwork(url: baseUrl+endPoint, method: "POST", headers: headers, data: data, completionHandler: completionHandler)
    }
    
    func put(endPoint:String, headers:[String:String]?, data:[String:Any]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        self.performNetwork(url: baseUrl+endPoint, method: "PUT", headers: headers, data: data, completionHandler: completionHandler)
    }
    
    func patch(endPoint:String, headers:[String:String]?, data:[String:Any]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        self.performNetwork(url: baseUrl+endPoint, method: "PATCH", headers: headers, data: data, completionHandler: completionHandler)
    }
    
    func delete(endPoint:String, headers:[String:String]?, completionHandler:@escaping (_ data:Data?, _ error:String?) -> Void) {
        self.performNetwork(url: baseUrl+endPoint, method: "DELETE", headers: headers, data: nil, completionHandler: completionHandler)
    }
}

extension NetworkService {
    // MARK: - Service errors
    enum NetworkServiceError: String {
        case InvalidUrl = "InvalidUrl"
        case Timeout = "Timeout"
        case Disconnected = "Disconnected"
        case Other = "TechnicalError"
    }
}

extension NetworkService {
    // MARK: - Status errors
    enum NetworkStatusError: Int {
        case status400 = 400
        case status401 = 401
        case status403 = 403
        case status404 = 404
        case status500 = 500
        case Other = -1
    }
    
    func getNetworkStatusError(nse: NetworkStatusError) -> String {
        switch nse {
        case .status400:
            return "BadRequest"
        case .status401:
            return "NotAuthorized"
        case .status403:
            return "Forbidden"
        case .status404:
            return "NotFound"
        case .status500:
            return "InternalServerError"
        default:
            return "Other400To500Error"
        }
    }
}
