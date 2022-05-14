//
//  HomeVC+CollectionView.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 14.05.2022.
//

import UIKit

enum LayoutConstants {
    static let spacing: CGFloat = 8.0
    static let itemHeight: CGFloat = 200.0
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifire,
                                                            for: indexPath) as? PhotoCell else {return UICollectionViewCell()}

        let photo = photoArray[indexPath.row]
        cell.configurePhotoCell(photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        navigationController?.pushViewController(DetailsViewController(id: photoArray[indexPath.row].id,
                                                                       image: photoArray[indexPath.row].photo,
                                                                       url: photoArray[indexPath.row].url),
                                                 animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let wight = itemWidth(for: self.mainView.frame.width, spacing: 0)

        return CGSize(width: wight, height: LayoutConstants.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {

        let itemInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemInRow
        
        return finalWidth - 5.0
    }
}
