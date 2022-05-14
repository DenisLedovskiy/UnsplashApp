//
//  SelectedPhoto.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import Foundation

struct SelectedPhoto: Codable {
    let id: String
    let created_at: String
    let urls: SelectedPhotoUrls
    let user: SelectedPhotoUser
    let location: SelectedPhotoLocation
    let downloads: Int

}

struct SelectedPhotoLocation: Codable {
    let name: String?
    let title: String?
    let city: String?
    let country: String?
}

struct SelectedPhotoUrls: Codable {
    let regular: String?
    let small: String?
}

struct SelectedPhotoUser: Codable {
    let id: String?
    let name: String
}

