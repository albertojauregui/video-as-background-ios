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
        
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("backgroundVideo", ofType: "mp4")
        player = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.view.layer.addSublayer(playerLayer)
        
        player!.seekToTime(kCMTimeZero)
        player!.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

