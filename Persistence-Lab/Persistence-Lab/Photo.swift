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
    var largeImageURL: String
    var likes: Int?
    var imageURL: String
    var tags: String
}

