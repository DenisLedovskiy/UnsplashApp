//
//  UIImageExtension.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 02.05.2022.
//
import UIKit

extension UIImage {

    func newSizeImage(width: CGFloat, height: CGFloat) -> UIImage {

        let width = width
        let height = height
        var newImage: UIImage

        let renderFormat = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
}
