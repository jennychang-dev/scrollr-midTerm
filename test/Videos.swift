//
//  Videos.swift
//  test
//
//  Created by Test on 31/01/2019.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import UIKit
import Firebase

class Videos: NSObject {
    
    func retrieveVideos(dictionary: [String:AnyObject]) {

        let storageRef = Storage.storage().reference(forURL: "gs://shittyvine.appspot.com/Video #129")
        
        let httpsRef = Storage.storage().reference(forURL: "https://firebasesto...f3-b54a-df8ffbf639d8")
        
        let downloadTask = Storage.storage().reference().child("Video #129").write(toFile: )
       
        
        
    }

}
