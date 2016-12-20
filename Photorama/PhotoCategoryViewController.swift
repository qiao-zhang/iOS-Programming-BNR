//
//  PhotoCategoryViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class PhotoCategoryViewController: UITableViewController {
  
  
  // MARK: Table View Data Source
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return PhotoCategory.allValues.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "PhotoCategoryCell",
                                    for: indexPath)
    cell.textLabel!.text = PhotoCategory.allValues[indexPath.row].rawValue
    return cell
  }
  
  // MARK: Table View Delegate
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "ShowPhotoTitles",
                 sender: PhotoCategory.allValues[indexPath.row])
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "ShowPhotoTitles"?:
      let photoTitlesVC = segue.destination as! PhotoTitlesViewController
      photoTitlesVC.dataModel = DataModelWithURLSession()
      let category = sender as! PhotoCategory
      photoTitlesVC.photoCategory = category
      photoTitlesVC.navigationItem.title = category.rawValue
    case "ShowThumbnails"?:
      let thumbnailsVC = segue.destination
      let cell = sender as! UITableViewCell
      thumbnailsVC.navigationItem.title = cell.textLabel!.text! + " II"
    default:
      break
    }
  }
}
