//
//  AccessPhotoViewController+RetrieveFromFirebase.swift
//  test
//
//  Created by Test on 01/02/2019.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import Foundation
import FirebaseStorage
import AVKit

extension AccessPhotoViewController {

@IBAction func tryToPlay(_ sender: Any)
{
    self.playVideo()
}

    func playVideo() {

        print("is this NIL????? \(videoName)")
        let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(videoName)?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec")
        
        let player = AVPlayer(url: onlineUrl!)
        
        
        let avCtrl = AVPlayerViewController ()
        
        self.present(avCtrl, animated: true, completion: nil)
        
        avCtrl.player = player
        player.play()
    }

}
