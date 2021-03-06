//
//  ImageStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

protocol ImageStore {
  func fetchImageAsync(
    for photo: Photo,
    then callback: @escaping (FetchImageResult) -> Void)
}

enum FetchImageResult {
  case success(UIImage)
  case failure(Error)
}

enum ImageError: Error {
  case imageCreationError
}
