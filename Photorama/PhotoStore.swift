//
//  PhotoStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

protocol PhotoStore {
  func fetchPhotosAsync(for category: PhotoCategory,
    then handle: @escaping (FetchPhotosResult) -> Void)
}

enum FetchPhotosResult {
  case success([Photo])
  case failure(Error)
}
