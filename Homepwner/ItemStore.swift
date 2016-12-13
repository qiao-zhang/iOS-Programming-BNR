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
