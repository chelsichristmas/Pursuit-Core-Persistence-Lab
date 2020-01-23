//
//  Photos.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/22/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation


struct Photo: Codable {
    
    var hits: [PhotoInfo]
}

struct PhotoInfo: Codable {
    var videos: VideoInfo
    var userImageURL: String
}

struct VideoInfo: Codable {
    var tiny: VideoSizeInfo
}

struct VideoSizeInfo: Codable {
    var url: String
}
