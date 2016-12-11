//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Qiao Zhang on 12/10/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  var mapView: MKMapView!
}

// MARK: - View Life Cycle
extension MapViewController {
  
  override func loadView() {
    mapView = MKMapView()
    view = mapView
    
    let standardString = NSLocalizedString("Standard",
                                           comment: "Standrad map view")
    let hybridString = NSLocalizedString("Hybrid",
                                         comment: "Hybrid map view")
    let satelliteString = NSLocalizedString("Satellite",
                                            comment: "Satellite map view")
    
    let segmentedControl =
      UISegmentedControl(items: [standardString, hybridString, satelliteString])
    segmentedControl.backgroundColor =
      UIColor.white.withAlphaComponent(0.5)
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segmentedControl)
    
    let marginsGuide = view.layoutMarginsGuide
    
    let topConstraint =
      segmentedControl.topAnchor.constraint(
        equalTo: topLayoutGuide.bottomAnchor)
    
    let leadingConstraint =
      segmentedControl.leadingAnchor.constraint(
        equalTo: marginsGuide.leadingAnchor)
    let trailingConstraint =
      segmentedControl.trailingAnchor.constraint(
        equalTo: marginsGuide.trailingAnchor)
    
    [topConstraint, leadingConstraint, trailingConstraint].forEach {
      $0.isActive = true
    }
    
    segmentedControl.addTarget(
      self,
      action: #selector(MapViewController.mapTypeChanged),
      for: .valueChanged)
  }
}

private extension MapViewController {
  @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
    switch segControl.selectedSegmentIndex {
    case 0:
      mapView.mapType = .standard
    case 1:
      mapView.mapType = .hybrid
    case 2:
      mapView.mapType = .satellite
    default:
      break
    }
  }
}
