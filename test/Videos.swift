import UIKit
import Firebase

class Videos: NSObject {
    
    var videoTitle: String = ""
    var videoURL: String = ""
    var videos: [String] = []
    
    init(name: String, url: String) {
        self.videoTitle = name
        self.videoURL = url
    }
    
    func addVideoToMyArray(url: String) {
        self.videos.append(videoURL)
    }
    
    func printItemsInMyArray() {
        
        for video in self.videos {
            print(video)
        }
    }
    
}
