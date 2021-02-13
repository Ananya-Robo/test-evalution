//
//  HomeScreenViewModel.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import Foundation
class HomeScreenViewModel {
    var bannerImageData: BannerImageModel?
    var videoDetail: VideoModel?
 
    func getHomeScreenBannerImage(completion: @escaping (_ success:Bool, _ error: NSError?) -> Void) {
        
        var params = [String:String]()
        params["per_page"] = "1"
        NetworkManager().getServerResponse(isTypeImage: true, apiEndPoint: HomeScreenApiEndPoint.bannedImage, method: .get, params: params, bodyParameter: nil) { (data, error) in
            if error != nil {
                completion(false,error)
            }
            guard let responsedata = data  else {
                completion(false,NSError(domain: "Empty response", code: 1, userInfo: nil))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers)
                if let jsonDict = json as? NSDictionary {
                    print("\n jsonDict \(jsonDict)")
                }
                let decoder = JSONDecoder()
                let bannerImageModel = try decoder.decode(BannerImageModel.self, from: responsedata)
                self.bannerImageData = bannerImageModel
                completion(true,nil)
            } catch let error as NSError {
                print("\(error.description)")
                completion(false,error)
            }
        }
    }
    
    func getHomeScreenListOfItems(isTypePhoto: Bool, searchedvalued: String, completion: @escaping (_ success:Bool, _ error: NSError?) -> Void) {
        
        var params = [String:String]()
        params["per_page"] = "20"
        params["query"] = searchedvalued
        
        NetworkManager().getServerResponse(isTypeImage: isTypePhoto, apiEndPoint: HomeScreenApiEndPoint.searchImage, method: .get, params: params, bodyParameter: nil) { (data, error) in
            if error != nil {
                completion(false,error)
            }
            guard let responsedata = data  else {
                completion(false,NSError(domain: "Empty response", code: 1, userInfo: nil))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers)
                if let jsonDict = json as? NSDictionary {
                    print("\n jsonDict \(jsonDict)")
                }
                let decoder = JSONDecoder()
                if isTypePhoto == true {
                    let bannerImageModel = try decoder.decode(BannerImageModel.self, from: responsedata)
                    self.bannerImageData = bannerImageModel
                }else{
                    let videoModel = try decoder.decode(VideoModel.self, from: responsedata)
                    self.videoDetail = videoModel
                    
                }
                completion(true,nil)
            } catch let error as NSError {
                print("\(error.description)")
                completion(false,error)
            }
        }
    }
}
