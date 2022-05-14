//
//  SearchPhoto.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import Foundation

struct SearchPhoto: Codable {
    let results: [SearchResuls]
}

struct SearchResuls: Codable {
    let id: String
    let urls: SearchUrls
}

struct SearchUrls: Codable {
    let regular: String
    let small: String
}

