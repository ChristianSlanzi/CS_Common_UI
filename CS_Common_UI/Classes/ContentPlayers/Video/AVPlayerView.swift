//
//  AVPlayerView.swift
//  FitGoal
//
//  Created by Christian Slanzi on 22.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AVPlayerView: UIView {
  // Add player property so the video the layer shows can be updated
  var player: AVPlayer? {
    get {
      return playerLayer.player
    }

    set {
      playerLayer.player = newValue
    }
  }
  
  // Override the layerClass
  override class var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
  
  // Add accessor for playerLayer so you don't need to
  var playerLayer: AVPlayerLayer {
    return (layer as? AVPlayerLayer)!
  }
}
