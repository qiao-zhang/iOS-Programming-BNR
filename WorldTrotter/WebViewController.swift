//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Qiao Zhang on 12/11/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  var webView: WKWebView!
}


// MARK: - View Life Cycle
extension WebViewController {
  override func loadView() {
    webView = WKWebView()
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let url = URL(string: "https://www.bignerdranch.com/")!
    let request = URLRequest(url: url)
    webView.load(request)
  }
}
