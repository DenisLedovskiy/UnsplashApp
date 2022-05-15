//
//  FavouriteViewController.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 29.04.2022.
//

import UIKit
import CoreData
import AlamofireImage

class FavouriteViewController: UIViewController {

    // MARK: - Properties

    var mainView: FavouriteView { return self.view as! FavouriteView  }

    let getImage = GetImageService()
    
    var favouritePhoto: [FavouritePhoto] = []

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<FavouritePhoto> = FavouritePhoto.fetchRequest()

        do {
            favouritePhoto  = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        self.mainView.tableView.reloadData()

        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
        self.mainView.tableView.register(FavouritePhotoCell.self,
                                         forCellReuseIdentifier: FavouritePhotoCell.identifire)
    }
    
    override func loadView() {
        self.view = FavouriteView(frame: UIScreen.main.bounds)
    }
}




