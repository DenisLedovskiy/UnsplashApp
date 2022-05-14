//
//  FavouritePhotoCell.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 30.04.2022.
//

import UIKit

final class FavouritePhotoCell: UITableViewCell {

    // MARK: - Properties

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        imageView.contentMode = .left
        return imageView
    }()

    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        setupViewsCell()
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewsCell() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupLayouts() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor,
                                               constant: (photoImageView.frame.width + 20)),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }

    func configureFavouritePhotoCell(_ photoArray: UIImage, name: String) {
        nameLabel.text = name
        photoImageView.image = photoArray
    }
}

extension FavouritePhotoCell: ReusableView {
    static var identifire: String {
        return String(describing: self)
    }
}
