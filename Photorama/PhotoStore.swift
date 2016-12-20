//
//  PhotoStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

protocol PhotoStore {
  var photos: [Photo] { get set }
  var photoCategory: PhotoCategory! { get set }
  func fetchPhotosAsync(
    then handle: @escaping () -> Void)
}

enum FetchPhotosResult {
  case success([Photo])
  case failure(Error)
}
