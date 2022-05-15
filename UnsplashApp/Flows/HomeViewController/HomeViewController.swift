//
//  HomeViewController.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    // MARK: - Properties

    var mainView: HomeView { return self.view as! HomeView }

    var tapScreen: UIGestureRecognizer!
    let getImage = GetImageService()

    var photoArray = [PhotoForCell]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        requestRandomPhoto()
        self.mainView.collectionView.dataSource = self
        self.mainView.collectionView.delegate = self
        self.mainView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifire)
        self.mainView.searchBar.delegate = self
    }

    override func loadView() {
        self.view = HomeView(frame: UIScreen.main.bounds)
    }

    //MARK: - TapGestureRecognizer

    func setTapGestureRecognizer() {
        self.tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        self.tapScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapScreen)
    }

    @objc func tapFunc() {
        self.view.endEditing(true)
    }

    // MARK: - Private funcs

    private func requestRandomPhoto() {

        let urlPhoto = "https://api.unsplash.com/photos"
        let accesKey = "vZtCkFdbaBjR3oG5N2gMwZNN-MqHqqxGDnPgoDcbwtg"


        AF.request(urlPhoto, parameters: [
            "client_id": accesKey
        ]).responseData { data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode([RandomPhoto].self, from: data)
                DispatchQueue.main.async {
                    self.fillPhotoArray(response)
                    self.mainView.collectionView.reloadData()
                }
            } catch (let error) {
                print (error)
            }
        }
    }

    private func fillPhotoArray(_ randomPhoto: [RandomPhoto]) {

        let randomPhotoCount = randomPhoto.count

        for i in 0...randomPhotoCount - 1 {
            guard let image = getImage.getImage(from: (randomPhoto[i].urls.small)) else { return }
            photoArray.append(PhotoForCell(id: randomPhoto[i].id,
                                           photo: image,
                                           url: randomPhoto[i].urls.small))
        }
    }

    private func searchRequest(with query: String) {

        let searchText = query
        let urlPhoto = "https://api.unsplash.com/search/photos"
        let accesKey = "vZtCkFdbaBjR3oG5N2gMwZNN-MqHqqxGDnPgoDcbwtg"

        AF.request(urlPhoto, parameters: [
            "query": searchText,
            "pages": "1",
            "client_id": accesKey
        ]).responseData { [self] data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(SearchPhoto.self, from: data)
                let pars = response.results
                self.photoArray = []

                for i in 0...pars.count - 1 {
                    guard let image = self.getImage.getImage(from: (pars[i].urls.small)) else { return }
                    self.photoArray.append(PhotoForCell(id: pars[i].id,
                                                        photo: image,
                                                        url: pars[i].urls.small))

                    DispatchQueue.main.async { [self] in
                        self.mainView.collectionView.reloadData()
                        self.view.endEditing(true)
                    }
                }
            } catch (let error) {
                print (error)
            }
        }
    }
}

//MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.searchRequest(with: query)
    }

}
