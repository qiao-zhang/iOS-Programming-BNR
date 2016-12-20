//
//  DataModel.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

protocol DataModel: PhotoStore, ImageStore {
  
}

class DataModelWithURLSession: DataModel {
  
  var imageCache = NSCache<NSString, UIImage>()
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchPhotosAsync(
    for category: PhotoCategory,
    then callback: @escaping (FetchPhotosResult) -> Void) {
    
    let url = FlickrAPI.photosURL(for: category)
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) {
      data, _, error in
      
      let result = self.processFetchPhotosResponse(data: data, error: error)
      callback(result)
    }
    
    task.resume()
  }
  
  func fetchImageAsync(for photo: Photo,
                       then callback: @escaping (FetchImageResult) -> Void) {
    if let image = imageCache.object(forKey: photo.photoID as NSString) {
      print("fetch from cache")
      callback(.success(image))
    } else {
      let photoURL = photo.remoteURL
      let request = URLRequest(url: photoURL)
      
      let task = session.dataTask(with: request) {
        data, response, error in
        let result = self.processFetchImageResponse(data: data, error: error)
        
        switch result {
        case .success(let image):
          self.imageCache.setObject(image, forKey: photo.photoID as NSString)
        default:
          break
        }
        
        callback(result)
      }
      task.resume()
    }
  }
  
  private func processFetchPhotosResponse(data: Data?,
                                          error: Error?) -> FetchPhotosResult {
    guard error == nil else { return .failure(error!) }
    do {
      let photos = try FlickrAPI.photos(from: data!)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
  
  private func processFetchImageResponse(data: Data?,
                                         error: Error?) -> FetchImageResult {
    guard
      let imageData = data,
      let image = UIImage(data: imageData) else {
        if let error = error {
          return .failure(error)
        }
        return .failure(ImageError.imageCreationError)
    }
    
    return .success(image)
  }
}
