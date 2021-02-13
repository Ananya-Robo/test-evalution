//
//  HomeScreenPresenter.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import Foundation

protocol HomeScreenPresenterOutput: class {
    
    func failedToObtainResponse(_ error: Error)
    func receivedBannerData(bannerImageData: BannerImageModel)
    func receivedListOfImages(imageList: BannerImageModel)
    func receivedListOfVideos(videoList: VideoModel)
}

enum Types: Int, CaseIterable {
    case Photos = 0
    case Videos
    case favorites
}

class HomeScreenPresenter: NSObject {
    
    init(presenterOutput: HomeScreenPresenterOutput) {
        self.output = presenterOutput
    }
    
    weak var output: HomeScreenPresenterOutput!
    var viewModel: HomeScreenViewModel? = HomeScreenViewModel()
    var bannerData: BannerImageModel?
    var listOfImages: BannerImageModel?
    var listOfVideos: BannerImageModel?
    
    func fetchBannerImage() {
        viewModel?.getHomeScreenBannerImage(completion: { (isSuccess, error) in
            if error != nil {
                if let serverError = error {
                    self.output.failedToObtainResponse(serverError)
                }
            } else {
                if let bannerData =  self.viewModel?.bannerImageData {
                    self.output.receivedBannerData(bannerImageData: bannerData)
                }
            }
        })
    }
    
    func fetchListOfImages(searchValue: String) {
        viewModel?.getHomeScreenListOfItems(isTypePhoto: true, searchedvalued: searchValue, completion: { (isSuccess, error) in
            if error != nil {
                if let serverError = error {
                    self.output.failedToObtainResponse(serverError)
                }
            } else {
                if let listOfImages =  self.viewModel?.bannerImageData {
                    self.output.receivedListOfImages(imageList: listOfImages)
                }
            }
        })
    }
    
    func fetchListOfVideos(searchValue: String) {
        viewModel?.getHomeScreenListOfItems(isTypePhoto: false, searchedvalued: searchValue, completion: { (isSuccess, error) in
            if error != nil {
                if let serverError = error {
                    self.output.failedToObtainResponse(serverError)
                }
            } else {
                if let listOfVideos =  self.viewModel?.videoDetail {
                    self.output.receivedListOfVideos(videoList: listOfVideos)
                }
            }
        })
    }
}
