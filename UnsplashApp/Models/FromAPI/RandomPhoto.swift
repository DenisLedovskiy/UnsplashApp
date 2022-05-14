//
//  RandomPhoto.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import Foundation

struct RandomPhoto: Codable {
    let id: String
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    let small: String
}
