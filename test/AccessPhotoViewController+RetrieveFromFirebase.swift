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
    let newRef = Storage.storage()
    let generateURL = newRef.reference().child("20190201_18_00_39.MOV")
    
    let vidName = "20190201_19_40_09"
    
    generateURL.downloadURL { url, error in
        if let error = error {
            // Handle any errors
        } else {
            print("it's worked PLEAAAAAAASEEEEEEE")
            print("\(generateURL)")
            
        }
    }
    
    let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(vidName).MOV?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec")
    
    let player = AVPlayer(url: onlineUrl!)
    
    
    let avCtrl = AVPlayerViewController ()
    
    self.present(avCtrl, animated: true, completion: nil)
    
    avCtrl.player = player
    player.play()
    
}

}
