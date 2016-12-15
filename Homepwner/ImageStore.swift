//
//  ImageStore.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/14/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class ImageStore {
  
  let cache = NSCache<NSString, UIImage>()
  let documentsDirectory =
    FileManager.default.urls(for: .documentDirectory,
                             in: .userDomainMask).first!
  
  func setImage(_ image: UIImage, forKey key: String) {
    cache.setObject(image, forKey: key as NSString)
    let url = imageURL(forKey: key)
    if let data = UIImageJPEGRepresentation(image, 0.5) {
      let _ = try? data.write(to: url, options: [.atomic])
    }
  }
  
  func image(forKey key: String) -> UIImage? {
    if let image = cache.object(forKey: key as NSString) { return image }
    
    let url = imageURL(forKey: key)
    guard let image = UIImage(contentsOfFile: url.path) else { return nil }
    cache.setObject(image, forKey: key as NSString)
    return image
  }
  
  func deleteImage(forKey key: String) {
    cache.removeObject(forKey: key as NSString)
    let url = imageURL(forKey: key)
    do {
      try FileManager.default.removeItem(at: url)
    } catch let deleteError {
      print("Error removing the image from disk: \(deleteError)")
    }
  }
  
  func imageURL(forKey key: String) -> URL {
    return documentsDirectory.appendingPathComponent(key)
  }
}
