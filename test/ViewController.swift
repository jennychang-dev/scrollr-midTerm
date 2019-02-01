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

class ViewController: UIViewController {

    var player = AVPlayer()
       override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
    func playVideo(num:Int) {
    
        guard let path = Bundle.main.path(forResource: "\(num)", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        //path = Bundle.main.path(forResource: "lol", ofType:"data")
        //URL(fileURLWithPath: url)
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        
        
        addChild(playerController)
        view.addSubview(playerController.view)
        
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let leftAnchor = playerController.view.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightAnchor = playerController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        leftAnchor.constant = -200
        rightAnchor.constant = 200
        
        leftAnchor.isActive = true
        rightAnchor.isActive = true
        
        player.play()
        
//        present(playerController, animated: true) {
//            player.play()
//        }
    }
    
    ///
    
    
    ///
    ///
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
