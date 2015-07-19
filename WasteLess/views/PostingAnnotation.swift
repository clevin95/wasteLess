//
//  PostingAnnotation.swift
//  WasteLess
//
//  Created by Carter Levin on 18/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit
import MapKit

class PostingAnnotation : NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  
  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
}