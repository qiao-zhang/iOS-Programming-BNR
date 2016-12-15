//
//  ItemStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

class ItemStore {
  
  // MARK: Properties
  var allItems: [Item]
  let itemArchiveURL: URL = {
    let documentsDirectory =
      FileManager.default.urls(for: .documentDirectory,
                               in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("items.archive")
  }()
  
  // MARK: Initializers
  init() {
    allItems =
      NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path)
        as? [Item] ?? []
  }
  
  // MARK: Methods updating items
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    allItems.append(newItem)
    return newItem
  }
  
  func removeItem(_ item: Item) {
    if let index = allItems.index(of: item) {
      allItems.remove(at: index)
    }
  }
  
  func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
    if sourceIndex == destinationIndex { return }
    let itemToMove = allItems.remove(at: sourceIndex)
    allItems.insert(itemToMove, at: destinationIndex)
  }
  
  // MARK: Methods for persistence
  func saveChanges() -> Bool {
    print("Save items to : \(itemArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allItems,
                                             toFile: itemArchiveURL.path)
  }
}
