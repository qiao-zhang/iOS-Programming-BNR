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
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView,
                 viewForHeaderInSection section: Int) -> UIView? {
    let headerLabel = UILabel()
    headerLabel.text = viewModel.headerFor(section: section)
    return headerLabel
  }
  
  override func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsIn(section: section)
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    let rowData = viewModel.getRowDataFor(indexPath: indexPath)
    
    cell.textLabel?.text = rowData.name
    cell.detailTextLabel?.text =
      numberFormatter.string(from: rowData.value as NSNumber)
    
    return cell
  }
}

extension ItemsViewController {

  class ViewModel {
    var sections: [Section] = []
    
    init(itemStore: ItemStore) {
      var itemsAbove50 = [Row]()
      var itemsUnder50 = [Row]()
      
      for item in itemStore.allItems {
        let row = Row(name: item.name, value: item.valueInDollars)
        if item.valueInDollars <= 50 {
          itemsUnder50.append(row)
        } else {
          itemsAbove50.append(row)
        }
      }
      
      sections = [Section(header: "Items Above 50", rows: itemsAbove50),
                  Section(header: "Items Under 50", rows: itemsUnder50)]
    }
    
    func numberOfSections() -> Int {
      return sections.count
    }
    func numberOfRowsIn(section: Int) -> Int {
      return sections[section].rows.count
    }
    func getRowDataFor(indexPath: IndexPath) -> Row {
      return sections[indexPath.section].rows[indexPath.row]
    }
    
    func headerFor(section: Int) -> String {
      return sections[section].header
    }
  }

  struct Section {
    var header: String
    var rows: [Row]
  }
  
  struct Row {
    var name: String
    var value: Int
  }

}
