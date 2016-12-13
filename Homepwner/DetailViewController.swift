//
//  DetailViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/13/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var serialNumberField: UITextField!
  @IBOutlet weak var valueField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
  
  var item: Item!
  
  let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 2
    nf.maximumFractionDigits = 2
    return nf
  }()
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium
    df.timeStyle = .none
    return df
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text =
      numberFormatter.string(from: item.valueInDollars as NSNumber)
    dateLabel.text =
      dateFormatter.string(from: item.dateCreated)
  }
}
