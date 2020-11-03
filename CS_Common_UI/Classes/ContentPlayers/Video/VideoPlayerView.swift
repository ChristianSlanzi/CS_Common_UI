//
//  VideoPlayerView.swift
//  FitGoal
//
//  Created by Christian Slanzi on 22.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class VideoPlayerView: UIView {
    let clip: Video
    let videoPlayerView = AVPlayerView()
    
    // Add player
    @objc private var player: AVPlayer!
    private var token: NSKeyValueObservation?
    
    public init(clip: Video) {
        self.clip = clip
        
        super.init(frame: .zero)
        
        // Set up the player
        initializePlayer()
        addGestureRecognizers()
    }
    
    // Set up player
    private func initializePlayer() {
        
        let asset = AVURLAsset(url: clip.url)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        
        videoPlayerView.player = player
        
        //addAllVideosToPlayer()
        
        player.volume = 1.0
        //player.play()
        
        /*
         token = player.observe(\.currentItem) { [weak self] player, _ in
         if player.items().count == 1 {
         self?.addAllVideosToPlayer()
         }
         }
         */
    }
    
    /*
     // Create player items from video URLs and insert them into the player's list
     private func addAllVideosToPlayer() {
     for video in clips {
     let asset = AVURLAsset(url: video.url)
     let item = AVPlayerItem(asset: asset)
     player.insert(item, after: player.items().last)
     }
     }
     */
    
    // Add methods to pause and play when the view leaves the screen
    public func pause() {
        player.pause()
    }
    
    public func play() {
        player.play()
    }
    
    // MARK: - Gestures
    
    // Add single and double tap gestures to the video player
    func addGestureRecognizers() {
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self,
                                               action: #selector(VideoPlayerView.wasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        
        tap.require(toFail: doubleTap)
        
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
    
    // Single tapping should toggle the pause volume
    @objc func wasTapped() {
        player.rate == 1.0 ? player.pause() : player.play()
        //    player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    // Double tapping should toggle the volume //rate between 2x and 1x
    @objc func wasDoubleTapped() {
        //    player.rate = player.rate == 1.0 ? 2.0 : 1.0
        player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    // MARK: - Unnecessary Code
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoPlayerView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        videoPlayerView.frame = bounds
        addSubview(videoPlayerView)
    }
}
