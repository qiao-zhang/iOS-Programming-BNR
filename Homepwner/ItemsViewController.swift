//
//  ItemsViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.index(of: newItem) {
      let indexPath  = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    if isEditing {
      sender.setTitle("Edit", for: .normal)
      setEditing(false, animated: true)
    } else {
      sender.setTitle("Done", for: .normal)
      setEditing(true, animated: true)
    }
  }
  
  var itemStore: ItemStore!
  
  let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .currency
    nf.locale = Locale.current
    return nf
  } ()
}

// MARK: - View Life Cycle
extension ItemsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    let insets = UIEdgeInsets(top: statusBarHeight, left: 0,
                              bottom: 0, right: 0)
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
  }
}

// MARK: - UITableViewDataSource
extension ItemsViewController {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    let item = itemStore.allItems[indexPath.row]
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text =
      numberFormatter.string(from: item.valueInDollars as NSNumber)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCellEditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      
      let title = "Delete \(item.name)?"
      let message = "Are you sure you want to delete this item?"
      let ac = UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel,
                                       handler: nil)
      let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive) { _ in
        self.itemStore.removeItem(item)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
      ac.addAction(cancelAction)
      ac.addAction(deleteAction)
      
      present(ac, animated: true, completion: nil)
    }
  }
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
}
