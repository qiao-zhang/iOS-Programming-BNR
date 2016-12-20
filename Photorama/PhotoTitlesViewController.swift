//
//  PhotosViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/16/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class PhotoTitlesViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  var photoStore: PhotoStore!
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    photoStore.fetchPhotosAsync {
      OperationQueue.main.addOperation {
        print("Fetched \(self.photoStore.photos.count) photos")
        self.tableView.reloadData()
      }
    }
  }
  
}

// MARK: - Table View Data Source
extension PhotoTitlesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return photoStore.photos.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Set up cell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTitleCell",
                                             for: indexPath)
    let photo = photoStore.photos[indexPath.row]
    cell.textLabel!.text = photo.title
    cell.detailTextLabel!.text = photo.dateTaken.description
    
    return cell
  }
}
