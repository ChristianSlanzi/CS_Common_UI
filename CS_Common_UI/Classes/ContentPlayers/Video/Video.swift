//
//  Video.swift
//  FitGoal
//
//  Created by Christian Slanzi on 22.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

public class Video: NSObject {
  let url: URL
  let thumbURL: URL
  let title: String
  let subtitle: String

  public init(url: URL, thumbURL: URL, title: String, subtitle: String) {
    self.url = url
    self.thumbURL = thumbURL
    self.title = title
    self.subtitle = subtitle
    super.init()
  }
}
