//
//  ItemDetailTextField.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/14/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ItemDetailTextField: UITextField {
  override func becomeFirstResponder() -> Bool {
    let tmp = super.becomeFirstResponder()
    borderStyle = .line
    return tmp
  }
  
  override func resignFirstResponder() -> Bool {
    let tmp = super.resignFirstResponder()
    borderStyle = .roundedRect
    return tmp
  }
}
