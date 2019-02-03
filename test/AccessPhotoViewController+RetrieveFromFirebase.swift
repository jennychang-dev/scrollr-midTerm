import Foundation
import FirebaseStorage
import AVKit

extension AccessPhotoViewController {
    
    // testers - eventually remove
    @IBAction func tryToPlay(_ sender: Any)
    {
        self.playVideo()
    }
    
    // current not in use function
    func playVideo() {
        
        let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(videoName)?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec")
        
        let player = AVPlayer(url: onlineUrl!)
        let avCtrl = AVPlayerViewController ()
        
        self.present(avCtrl, animated: true, completion: nil)
        
        avCtrl.player = player
        player.play()
    }
    
}
