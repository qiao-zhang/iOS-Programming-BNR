//
//  ItemStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

class ItemStore {
  var allItems = [Item]()
  
  init() {
    for _ in 0 ..< 50 {
      createItem()
    }
  }
  
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    allItems.append(newItem)
    return newItem
  }
}

class ItemsViewModel {

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

extension ItemsViewModel {
  struct Section {
    var header: String
    var rows: [Row]
  }
  
  struct Row {
    var name: String
    var value: Int
  }
}
