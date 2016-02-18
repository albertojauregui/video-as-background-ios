//
//  ViewController.swift
//  VideoBackground
//
//  Created by Alberto Jauregui on 17/02/16.
//  Copyright © 2016 Alberto Jauregui. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("backgroundVideo", ofType: "mp4")
        player = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        // Set the actionAtItemEnd is important for the notification part
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Make sure that the video is added to the back of every layer in the view
        self.view.layer.insertSublayer(playerLayer, atIndex: 0)
        
        // Listen for notification when the video reach to the end
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification, object: player!.currentItem)
        
        player!.seekToTime(kCMTimeZero)
        player!.play()
        
        // we create a vertical UIMotionEffect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -10
        verticalMotionEffect.maximumRelativeValue = 10
        
        // Another horizontal one
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -10
        horizontalMotionEffect.maximumRelativeValue = 10
        
        // Now we create a group of both effects, and assign it to our root view
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        self.view.addMotionEffect(group)

    }
    
    func playerItemDidReachEnd() {
        player!.seekToTime(kCMTimeZero)
    }
}

