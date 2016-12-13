//
//  ItemsViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
  var viewModel: ViewModel!
  
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
    tableView.dataSource = viewModel
  }
}


extension ItemsViewController {

  class ViewModel: NSObject, UITableViewDataSource {
    
    var itemStore: ItemStore
    var sections: [Section] = []
    let numberFormatter: NumberFormatter = {
      let nf = NumberFormatter()
      nf.numberStyle = .currency
      nf.locale = Locale.current
      return nf
    } ()
    
    init(itemStore: ItemStore) {
      self.itemStore = itemStore
      super.init()
      updateSections()
    }
    
    func updateSections() {
      let rows =
        itemStore.allItems.map { item in
          Row(title: item.name,
              detail: numberFormatter.string(
                from: item.valueInDollars as NSNumber)!)
        }
      let section = Section(header: "", rows: rows)
      sections = [section]
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
      return sections[section].rows.count + 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.row == sections[indexPath.section].rows.count {
        let cell =
          tableView.dequeueReusableCell(withIdentifier: "NoMoreItemsCell",
                                        for: indexPath)
        return cell
      }
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                      for: indexPath)
      let rowData = sections[indexPath.section].rows[indexPath.row]
      cell.textLabel?.text = rowData.title
      cell.detailTextLabel?.text = rowData.detail
      return cell
    }
  }

  struct Section {
    var header: String
    var rows: [Row]
  }
  
  struct Row {
    var title: String
    var detail: String
  }

}
