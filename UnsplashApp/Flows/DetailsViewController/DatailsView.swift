//
//  DatailsView.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit
import Alamofire

class DetailsView: UIView {

    // MARK: - Properties

    var labelSelected = UILabel()
    var labelLocation = UILabel()
    var labelDownloads = UILabel()
    var detailImage: UIImageView?
    
    var onAddLikeButtonAction: (() -> Void)?

    let likeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        configure(image: image)
        addActrions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .blue
    }

    func configure(image: UIImage) {

        self.backgroundColor = .white

        detailImage = UIImageView(image: image)
        self.addSubview(detailImage!)
        detailImage!.translatesAutoresizingMaskIntoConstraints = false
        detailImage!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        detailImage!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailImage!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        detailImage!.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        detailImage!.contentMode = .scaleAspectFit

        self.addSubview(labelSelected)
        labelSelected.translatesAutoresizingMaskIntoConstraints = false
        labelSelected.centerXAnchor.constraint(equalTo: detailImage!.centerXAnchor).isActive = true
        labelSelected.topAnchor.constraint(equalTo: detailImage!.topAnchor, constant: -100).isActive = true

        self.addSubview(labelLocation)
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        labelLocation.centerXAnchor.constraint(equalTo: detailImage!.centerXAnchor).isActive = true
        labelLocation.topAnchor.constraint(equalTo: detailImage!.topAnchor, constant: -80).isActive = true

        self.addSubview(labelDownloads)
        labelDownloads.translatesAutoresizingMaskIntoConstraints = false
        labelDownloads.centerXAnchor.constraint(equalTo: detailImage!.centerXAnchor).isActive = true
        labelDownloads.topAnchor.constraint(equalTo: detailImage!.bottomAnchor, constant: 20).isActive = true

        self.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.centerXAnchor.constraint(equalTo: detailImage!.centerXAnchor).isActive = true
        likeButton.topAnchor.constraint(equalTo: labelDownloads.bottomAnchor).isActive = true
    }

    private func addActrions() {
        likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
    }

    @objc
    private func likeButtonPressed() {
        onAddLikeButtonAction?()
    }
}
