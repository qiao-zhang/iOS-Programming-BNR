//
//  FlickrAPI.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/16/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

enum Method: String {
  case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickAPI {
  
  static var interestingPhotosURL: URL {
    return flickrURL(method: .interestingPhotos,
                     parameters: ["extras": "url_h,date_taken"])
  }
  private static let baseUILString = "https://api.flickr.com/services/rest"
  private static let apiKey = "a6d819499131071f158fd740860a5a88"
  
  private static func flickrURL(method: Method,
                                parameters: [String: String]?) -> URL {
    var components = URLComponents(string: baseUILString)!
    var queryItems = [URLQueryItem]()
    
    let baseParams = [
      "method": method.rawValue,
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
