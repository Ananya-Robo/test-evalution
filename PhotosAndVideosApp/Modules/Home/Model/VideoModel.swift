//
//  VideoModel.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import Foundation
// MARK: - VideoModel
class VideoModel: Codable {
    let page, perPage, totalResults: Int
    let url: String
    let videos: [Video]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case url, videos
    }

    init(page: Int, perPage: Int, totalResults: Int, url: String, videos: [Video]) {
        self.page = page
        self.perPage = perPage
        self.totalResults = totalResults
        self.url = url
        self.videos = videos
    }
}

// MARK: - Video
class Video: Codable {
    let id, width, height: Int
    let url: String
    let image: String
    let duration: Int
    let user: User
    let videoFiles: [VideoFile]
    let videoPictures: [VideoPicture]

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, image, duration, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }

    init(id: Int, width: Int, height: Int, url: String, image: String, duration: Int, user: User, videoFiles: [VideoFile], videoPictures: [VideoPicture]) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
        self.image = image
        self.duration = duration
        self.user = user
        self.videoFiles = videoFiles
        self.videoPictures = videoPictures
    }
}

// MARK: - User
class User: Codable {
    let id: Int
    let name: String
    let url: String

    init(id: Int, name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
}

// MARK: - VideoFile
class VideoFile: Codable {
    let id: Int
    let quality, fileType: String
    let width, height: Int?
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, link
    }

    init(id: Int, quality: String, fileType: String, width: Int?, height: Int?, link: String) {
        self.id = id
        self.quality = quality
        self.fileType = fileType
        self.width = width
        self.height = height
        self.link = link
    }
}

// MARK: - VideoPicture
class VideoPicture: Codable {
    let id: Int
    let picture: String
    let nr: Int

    init(id: Int, picture: String, nr: Int) {
        self.id = id
        self.picture = picture
        self.nr = nr
    }
}
