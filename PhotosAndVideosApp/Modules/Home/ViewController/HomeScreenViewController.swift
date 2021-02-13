//
//  HomeScreenViewController.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class HomeScreenViewController: BaseViewController {
    //MARK: Outlets
    @IBOutlet weak var headerHoldingView: UIView!
    @IBOutlet weak var largeHeaderConstaints: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var AllItemTableView: UITableView!
    //MARK: Properties
    lazy var homeScreenPresenter: HomeScreenPresenter = {
        let presenter = HomeScreenPresenter(presenterOutput: self)
        return presenter
    }()
    lazy var activityIndicator = ActivityIndicatorView()
    let maxHeaderHeight: CGFloat = UIScreen.main.bounds.size.height / 3
    let minHeaderHeight: CGFloat = 80
    var previousScrollOffset: CGFloat = 0
    private var largeHeaderView: LargeHeaderView?
    let searchString: String = "animal"
    var typeSelected: Types? = .Photos
    var bannerImage: BannerImageModel?
    var listOfImages: BannerImageModel?
    var listOfVideos: VideoModel?
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getBannerImage()
        registerNibs()
    }
    //MARK: storyboard init helper
    class var instance: HomeScreenViewController {
        return Storyboard.home.instantiateVC(HomeScreenViewController.self)
    }
    //MARK: Methods
    func setupView() {
        self.headerView.searchButton.isHidden = true
    }
    
    func displayHeaderView() {
         if largeHeaderView == nil {
            if let header = LargeHeaderView.getInstance() {
                largeHeaderView = header
                header.setupView(with: headerHoldingView.bounds,
                                 title: Constants.bannerMainTitle,
                                 subTitle: Constants.bannerSubTitle, backgroundImage: bannerImage?.photos[0].src.small ?? "")
                headerHoldingView.addSubview(header)
                headerHoldingView.layoutIfNeeded()
            }
        }
    }
    
    private func registerNibs() {
        AllItemTableView.registerNib(PhotoListTableViewCell.self)
    }
    
    func getBannerImage() {
        activityIndicator.showActivityIndicator(view: self.view)
        homeScreenPresenter.fetchBannerImage()
    }
    
    func getListOfItems(isImage: Bool) {
        activityIndicator.showActivityIndicator(view: self.view)
        if isImage == true {
        homeScreenPresenter.fetchListOfImages(searchValue: searchString)
        }else {
            homeScreenPresenter.fetchListOfVideos(searchValue: searchString)
        }
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if typeSelected == .Photos{
            count = listOfImages?.photos.count ?? 0
            
        }else if typeSelected == .Videos {
            count = listOfVideos?.videos.count ?? 0
        }
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(PhotoListTableViewCell.self, indexPath: indexPath)
        if typeSelected == .Photos {
        if let listOfImages = listOfImages?.photos{
            cell.configureHomeScreenCell(imageDetail: listOfImages[indexPath.row])
        }
        }else {
            if let listOfVideos = listOfVideos?.videos{
                cell.configureHomeVideoCell(videoDetail: listOfVideos[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = SectionHeader.getInstance()
        headerView?.delegate = self
        headerView?.configureHeaderView(isType: typeSelected ?? .Photos)
        return headerView
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
            // Call your api here
            // Send true in onSuccess in case new data exists, sending false will disable pagination
            
//            // If page number is first, reset the list
//            if pageNumber == 1 { self.list = [Int]() }
//            
//            // else append the data to list
//            let startFrom = (self.list.last ?? 0) + 1
//            for number in startFrom..<(startFrom + pageSize) {
//                self.list.append(number)
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onSuccess?(true)
            }
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.01))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppFlowManager.shared.loadImageDetailScreen(on: self)
    }
}


//MARK: UIScrollViewDelegate
extension HomeScreenViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = CGFloat(Constants.scrollAbsoluteTopPostion)
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
         let isScrollingUp =  (scrollView.contentOffset.y <= absoluteTop)
        
        if canAnimateHeader(scrollView) {
            // Calculate new header height
            var newHeight = self.largeHeaderConstaints.constant
            if isScrollingDown {
                self.largeHeaderView?.collapsLargerHeader()
                self.headerView.searchButton.isHidden = false
                newHeight = max(self.minHeaderHeight, self.largeHeaderConstaints.constant - abs(scrollDiff))
            } else if isScrollingUp {
                 self.largeHeaderView?.expandlargeHeader()
                self.headerView.searchButton.isHidden = true
                newHeight = min(self.maxHeaderHeight, self.largeHeaderConstaints.constant + abs(scrollDiff))
            }
            
            // Header needs to animate
            if newHeight != self.largeHeaderConstaints.constant {
                self.largeHeaderConstaints.constant = newHeight
               // self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.largeHeaderConstaints.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.largeHeaderConstaints.constant = self.minHeaderHeight
            self.view.layoutIfNeeded()
            
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.largeHeaderConstaints.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        })
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.AllItemTableView.contentOffset = CGPoint(x: self.AllItemTableView.contentOffset.x, y: position)
    }
}

extension HomeScreenViewController: HomeScreenPresenterOutput {
    func receivedListOfVideos(videoList: VideoModel) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            self.listOfVideos = videoList
            self.AllItemTableView.reloadData()
        }
    }
    
    func receivedBannerData(bannerImageData: BannerImageModel) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            self.bannerImage = bannerImageData
            self.displayHeaderView()
            self.getListOfItems(isImage: true)
            
        }
    }
    
    func receivedListOfImages(imageList: BannerImageModel) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
             self.listOfImages = imageList
            self.AllItemTableView.reloadData()
        }
    }
    
    func failedToObtainResponse(_ error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            print("error*******")
        }
    }
}

extension HomeScreenViewController: SectionHeaderDelegate {
    
    func selectedType(type: Types) {
        if type == .Photos {
            self.typeSelected = .Photos
            getListOfItems(isImage: true)
        } else {
            self.typeSelected = .Videos
            getListOfItems(isImage: false)
        }
    }
}
