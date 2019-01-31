//
//  ViewController1.swift
//  test
//
//  Created by Yilei Huang on 2019-01-30.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController1: UIViewController {

    
       override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    
   
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "lol", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = true
        
        addChild(playerController)
        view.addSubview(playerController.view)
        
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        playerController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        player.play()
        
//        present(playerController, animated: true) {
//            player.play()
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
