//
//  FlickrAPI.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/16/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

protocol PhotoAPI {
  static func photosURL(for category: PhotoCategory) -> URL
  static func photos(from data: Data) throws -> [Photo]
}

protocol ImageAPI {
  
}

enum FlickrError: Error {
  case invalidJSONData(String)
}

class FlickrAPI: PhotoAPI, ImageAPI {
  
  private static let endpointDict: [PhotoCategory: String] = [
    .interestringPhotos: "flickr.interestingness.getList",
    .recentPhotos: "flickr.photos.getRecent"
  ]
  private static let baseUILString = "https://api.flickr.com/services/rest"
  private static let apiKey = "a6d819499131071f158fd740860a5a88"
  private static let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return df
  }()
  
  static func photosURL(for category: PhotoCategory) -> URL {
    let endpoint: String
    switch category {
    case .interestringPhotos:
      endpoint = "flickr.interestingness.getList"
    case .recentPhotos:
      endpoint = "flickr.photos.getRecent"
    }
    return flickrURL(method: endpoint,
                     parameters: ["extras": "url_h,date_taken"])
  }
  
  static func photos(from data: Data) throws -> [Photo] {
    let jsonObject = try JSONSerialization.jsonObject(with: data,
                                                      options: [])
    guard
      let jsonDict = jsonObject as? [AnyHashable: Any],
      let photosDict = jsonDict["photos"] as? [String: Any],
      let photosArray = photosDict["photo"] as? [[String: Any]] else {
        
        throw FlickrError.invalidJSONData("No photos or photo field")
    }
    
    var finalPhotos = [Photo]()
    for photoJSON in photosArray {
      if let photo = photo(from: photoJSON) {
        finalPhotos.append(photo)
      }
    }
    
    return finalPhotos
  }
  
  private static func photo(from json: [String: Any]) -> Photo? {
    
    guard
      let photoID = json["id"] as? String,
      let title = json["title"] as? String,
      let dateString = json["datetaken"] as? String,
      let dateTaken = dateFormatter.date(from: dateString),
      let photoURLString = json["url_h"] as? String,
      let url = URL(string: photoURLString) else {
        return nil
    }
    
    return Photo(title: title, remoteURL: url,
                 photoID: photoID, dateTaken: dateTaken)
  }
  
  static func flickrURL(method: String,
                        parameters: [String: String]?) -> URL {
    var components = URLComponents(string: baseUILString)!
    var queryItems = [URLQueryItem]()
    
    let baseParams = [
      "method": method,
      "format": "json",
      "nojsoncallback": "1",
      "api_key": apiKey
    ]
    
    for (name, value) in baseParams {
      let item = URLQueryItem(name: name, value: value)
      queryItems.append(item)
    }
    
    if let params = parameters {
      for (name, value) in params {
        let item = URLQueryItem(name: name, value: value)
        queryItems.append(item)
      }
    }
    components.queryItems = queryItems
    
    return components.url!
  }
}
