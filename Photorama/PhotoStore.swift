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

class PhotoStoreWithURLSession: PhotoStore {
  
  var photos = [Photo]()
  var photoCategory: PhotoCategory!
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchPhotosAsync(
    then callback: @escaping () -> Void) {
    
    let url = FlickrAPI.photosURL(for: photoCategory)
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) {
      data, _, error in
      
      let result = self.processResponse(data: data, error: error)
      
      switch result {
      case .success(let photos):
        self.photos = photos
      case .failure(let error):
        print("\(error)")
        self.photos = []
      }
      
      callback()
    }
    
    task.resume()
  }
  
  func processResponse(data: Data?, error: Error?) -> FetchPhotosResult {
    guard error == nil else { return .failure(error!) }
    do {
      let photos = try FlickrAPI.photos(from: data!)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}
