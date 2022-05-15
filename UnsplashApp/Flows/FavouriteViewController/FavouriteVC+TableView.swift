//
//  FavouriteVC+TableView.swift
//  UnsplashApp
//
//  Created by Денис Ледовский on 15.05.2022.
//

import UIKit
import CoreData

extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritePhoto.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let url = favouritePhoto[indexPath.row].photo else {return}

        navigationController?.pushViewController(DetailsViewController(id: favouritePhoto[indexPath.row].id!,
                                                                       image: getImage.getImage(from: url)!,
                                                                       url: favouritePhoto[indexPath.row].photo!),
                                                 animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritePhotoCell.identifire,
                                                       for: indexPath) as? FavouritePhotoCell else {return UITableViewCell()}

        let data = favouritePhoto[indexPath.row]
        if let image = self.getImage.getImage(from: data.photo ?? "")?.newSizeImage(width: 100, height: 80) {

            cell.configureFavouritePhotoCell((image),
                                             name: data.name ?? "Имя не указано")
        } else { return cell }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<FavouritePhoto> = FavouritePhoto.fetchRequest()


            if let photo = try? context.fetch(fetchRequest) {
                context.delete(photo[indexPath.row])
                self.favouritePhoto.remove(at: indexPath.row)
            }
            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
