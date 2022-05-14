//
//  GetImageService.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 14.05.2022.
//

import UIKit

class GetImageService {

    func getImage(from url: String) -> UIImage? {
        var image: UIImage?
        guard let imageURL = URL(string: url) else { return nil }

        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        image = UIImage(data: imageData)

        return image
    }
}
