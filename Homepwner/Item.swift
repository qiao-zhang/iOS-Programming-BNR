//
//  Item.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/12/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
  var name: String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  let itemKey: String
  
  init(name: String, valueInDollars: Int, serialNumber: String?) {
    self.name = name
    self.valueInDollars = valueInDollars
    self.serialNumber = serialNumber
    self.dateCreated = Date()
    itemKey = UUID().uuidString
    
    super.init()
  }
  
  convenience init(random: Bool = false) {
    if random {
      let adjs = ["Fluffy", "Rusty", "Shiny"]
      let nouns = ["Bear", "Spork", "Mac"]
      
      var idx = arc4random_uniform(UInt32(adjs.count))
      let randomAdj = adjs[Int(idx)]
      
      idx = arc4random_uniform(UInt32(nouns.count))
      let randomNoun = nouns[Int(idx)]
      
      let randomName = "\(randomAdj) \(randomNoun)"
      let randomValue = Int(arc4random_uniform(100))
      let randomSerialNumber =
        UUID().uuidString.components(separatedBy: "-").first!
      
      self.init(name: randomName,
                valueInDollars: randomValue,
                serialNumber: randomSerialNumber)
    } else {
      self.init(name: "", valueInDollars: 0, serialNumber: nil)
    }
  }
  
  // MARK: NSCoding
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
    itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
    serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
    valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(dateCreated, forKey: "dateCreated")
    aCoder.encode(itemKey, forKey: "itemKey")
    aCoder.encode(serialNumber, forKey: "serialNumber")
    aCoder.encode(valueInDollars, forKey: "valueInDollars")
  }
  
}

