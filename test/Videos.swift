import UIKit
import Firebase

class Videos: NSObject {
    
    var videoTitle: String = ""
    var videoURL: String = ""

    init(name: String, url: String) {
        self.videoTitle = name
        self.videoURL = url
    }
}
