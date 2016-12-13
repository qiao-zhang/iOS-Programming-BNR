//
//  ItemsViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
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
}
