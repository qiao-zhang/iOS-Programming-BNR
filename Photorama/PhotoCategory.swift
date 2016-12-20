//
//  PhotoCategory.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/19/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import Foundation

enum PhotoCategory: String {
  case interestringPhotos = "Interesting Photos"
  case recentPhotos = "Recent Photos"
  
  static let allValues: [PhotoCategory] = [.interestringPhotos, .recentPhotos]
}
