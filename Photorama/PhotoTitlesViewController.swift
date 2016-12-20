//
//  PhotosViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/16/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class PhotoTitlesViewController: UITableViewController {

  var dataModel: PhotoStore!
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    dataModel.fetchPhotosAsync {
      OperationQueue.main.addOperation {
        print("Fetched \(self.dataModel.photos.count) photos")
        self.tableView.reloadData()
      }
    }
  }

  // MARK: Table View Data Source
  override func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return dataModel.photos.count
  }

  override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Set up cell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTitleCell",
                                             for: indexPath)
    let photo = dataModel.photos[indexPath.row]
    cell.textLabel!.text = photo.title
    cell.detailTextLabel!.text = photo.dateTaken.description
    
    return cell
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowImage"?:
      let cell = sender as! UITableViewCell
      let imageVC = segue.destination
      imageVC.title = cell.textLabel!.text
    default:
      assertionFailure("invalid segue identifier")
    }
  }
}
