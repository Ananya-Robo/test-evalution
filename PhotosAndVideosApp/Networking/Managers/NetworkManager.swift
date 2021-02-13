//
//  NetworkManager.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {

    func getServerResponse(isTypeImage: Bool, apiEndPoint:String, method: RequestMethod, params:[String:String]?, bodyParameter:[String:Any]?, completion: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        let url = getCompountURl(isTypeImage: isTypeImage, with: params, apiEndPoint: apiEndPoint)
        print("\n URL \(apiEndPoint) =  \(String(describing: url))")
        
        var request = URLRequest(url:url)
        request.httpMethod = method.rawValue
        request.addValue(HomeScreenApiEndPoint.APIkey, forHTTPHeaderField: "Authorization")
        
        if bodyParameter != nil {
            let jsonbody: Data
            do {
                jsonbody = try JSONSerialization.data(withJSONObject: bodyParameter!, options: [])
                request.httpBody = jsonbody
                let json = try JSONSerialization.jsonObject(with: jsonbody, options: .mutableContainers)
                if let jsonDict = json as? NSDictionary {
                    print("\n Request \(jsonDict)")
                }
            } catch {
                completion(nil, NSError(domain: "error", code: 111, userInfo: nil))
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let responseData = data else {
                completion(nil, (error! as NSError))
                return
            }
            completion(responseData, nil)
        }.resume()
    }


    func getCompountURl(isTypeImage: Bool, with params:[String:Any]?,apiEndPoint:String) -> URL {
        let baseUrl: String
        switch isTypeImage {
        case true:
            baseUrl = HomeScreenApiEndPoint.baseImageURL
        case false:
            baseUrl = HomeScreenApiEndPoint.baseVideoURL
        }
        var urlComps = URLComponents(string: baseUrl+apiEndPoint)
        if let parameters = params {
            var queryItems = [URLQueryItem]()
            for aParam in parameters {
                queryItems.append(URLQueryItem(name: aParam.key, value: aParam.value as? String))
            }
            urlComps?.queryItems = queryItems
        }
        let url = urlComps?.url
        return url!
    }
}
