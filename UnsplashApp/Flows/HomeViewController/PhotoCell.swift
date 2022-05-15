//
//  PhotoCell.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit

private enum Constants {
    static let contentViewCornerRadius: CGFloat = 4.0
    static let imageHeight: CGFloat = 200.0
}

final class PhotoCell: UICollectionViewCell {

    // MARK: - Subviews

    let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewsCell()
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configurePhotoCell(_ photoArray: PhotoForCell) {
        photoImageView.image = photoArray.photo

    }

    // MARK: - UI

    private func setupViewsCell() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white

        contentView.addSubview(photoImageView)
    }

    private func setupLayouts() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight )
        ])
    }
}

// MARK: - Extension

extension PhotoCell: ReusableView {

    static var identifire: String {
        return String(describing: self)
    }
}

