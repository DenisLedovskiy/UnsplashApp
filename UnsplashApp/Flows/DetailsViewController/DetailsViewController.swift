//
//  DetailsViewController.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit
import Alamofire
import CoreData

class DetailsViewController: UIViewController {

    // MARK: - Properties

    var mainView: DetailsView { return self.view as! DetailsView  }

    private var id: String
    private var image: UIImage
    private var urlPhoto: String
    
    private var favouritePhoto: [FavouritePhoto] = []
    private var nameAuthor: String = ""

    // MARK: - Init

    init(id: String, image: UIImage, url: String) {
        self.image = image
        self.id = id
        self.urlPhoto = url
        super.init(nibName: nil, bundle: nil) }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Description"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        showSelectedView(id: id)
        self.mainView.onAddLikeButtonAction = { [weak self] in
            self?.tapLikeButton()
        }
    }

    override func loadView() {
        self.view = DetailsView(frame: UIScreen.main.bounds, image: image)
    }

    // MARK: - Private funcs

    private func showAlertAdd() {
        let alert = UIAlertController(title: "Ура!", message:"Фото добавлено в избранное", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    private func showAlertExist() {
        let alert = UIAlertController(title: "Упс!", message:"Такое фото уже есть в избранном", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }


    private func showSelectedView(id: String) {

        let urlPhoto = "https://api.unsplash.com/photos/\(id)/"
        let accesKey = "vZtCkFdbaBjR3oG5N2gMwZNN-MqHqqxGDnPgoDcbwtg"

        AF.request(urlPhoto, parameters: [
            "client_id": accesKey
        ]).responseData { [self] data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(SelectedPhoto.self, from: data)
                self.mainView.labelSelected.text = "Name: \(response.user.name)"
                self.mainView.labelLocation.text = "Location: \(response.location.city ?? "---"), \(response.location.country ?? "---")"
                self.mainView.labelDownloads.text = "Downloads: \(response.downloads)"

                self.nameAuthor = "\(response.user.name)"
            } catch (let error) {
                print (error)
            }
        }
    }

    // MARK: - View Actions

    private func tapLikeButton() {

        let urlText = self.urlPhoto
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()


        guard let entity = NSEntityDescription.entity(forEntityName: "FavouritePhoto",
                                                      in: context) else {return}


        fetchRequest.entity = entity
        let predicate = NSPredicate(format: "photo == %@", "\(urlText)")
        fetchRequest.predicate = predicate

        do{
            let object = try context.fetch(fetchRequest)
            if object.count == 0 {
                let taskObject = FavouritePhoto(entity: entity, insertInto: context)
                taskObject.name = self.nameAuthor
                taskObject.id = self.id
                taskObject.photo = self.urlPhoto
                do {
                    try context.save()
                    self.favouritePhoto.append(taskObject)
                    self.showAlertAdd()
                    self.mainView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else {
                self.showAlertExist()
                self.mainView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                return
            }
        } catch {
            fatalError("Failed to fetch memory: \(error)")
        }
    }
}
