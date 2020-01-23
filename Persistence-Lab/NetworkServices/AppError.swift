//
//  AppError.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/22/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String) 
}

