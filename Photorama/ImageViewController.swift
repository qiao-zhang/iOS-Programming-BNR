//
//  ImageViewController.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  var dataModel: DataModel!
  var photo: Photo!
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataModel.fetchImageAsync(for: photo) { result in
      switch result {
      case .success(let image):
        OperationQueue.main.addOperation {
          self.imageView.image = image
        }
      case .failure(let error):
        print("\(error)")
      }
    }
  }
}
