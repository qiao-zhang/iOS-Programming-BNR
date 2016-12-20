//
//  PhotosViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/16/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class PhotoTitlesViewController: UITableViewController {

  var dataModel: DataModel!
  var photoCategory: PhotoCategory!
  var photos: [Photo] = []
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    dataModel.fetchPhotosAsync(for: photoCategory) { result in
      
      switch result {
      case .success(let photos):
        self.photos = photos
      case .failure(let error):
        self.photos = []
        print("\(error)")
      }
      
      OperationQueue.main.addOperation {
        print("Fetched \(self.photos.count) photos")
        self.tableView.reloadData()
      }
    }
  }

  // MARK: Table View Data Source
  override func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }

  override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTitleCell",
                                             for: indexPath)
    let photo = photos[indexPath.row]
    cell.textLabel!.text = photo.title
    cell.detailTextLabel!.text = photo.dateTaken.description
    
    return cell
  }
  
  // MARK: Table View Delegate
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "ShowImage", sender: photos[indexPath.row])
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowImage"?:
      let photo = sender as! Photo
      let imageVC = segue.destination as! ImageViewController
      imageVC.photo = photo
      imageVC.navigationItem.title = photo.title
      imageVC.dataModel = dataModel
    default:
      assertionFailure("invalid segue identifier")
    }
  }
}
