//
//  ItemCell.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/13/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var serialNumberLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  
  var viewModel: ViewModel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    [nameLabel, serialNumberLabel, valueLabel].forEach {
      $0?.adjustsFontForContentSizeCategory = true
    }
  }
}

extension ItemCell {
  struct ViewModel {
    var nameLabelText: String
    var serialNumberLabelText: String
    var valueLabelText: String
  }
}
