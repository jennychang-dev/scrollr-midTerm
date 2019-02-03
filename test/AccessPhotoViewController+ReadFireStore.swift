import Foundation
import Firebase
import AVKit

extension AccessPhotoViewController
    
{
    func readFireStore()
    {
        
        let databaseRef = Firestore.firestore()
        databaseRef.collection("videoData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let videoName = document.data()["Date added"]
                    let videoURL = document.data()["Video URL"]
                    
                    // Create a new video instance
                    let aVideo = Videos(name: videoName as! String, url: videoURL as! String)
                    self.videos.append(aVideo.videoURL)
                    
                }
                
            }
            
        }
        
    }
    
    func convertToUnique() -> [String] {
        let unique = Array(Set(self.videos))
        print(unique.count)
        return unique
    }
    
    @IBAction func tryToPlay(_ sender: Any)
    {
        self.playVideo()
    }
    
    func playVideo() {
        
        let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(videoName)?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec")
        
        let player = AVPlayer(url: onlineUrl!)
        let avCtrl = AVPlayerViewController ()
        
        self.present(avCtrl, animated: true, completion: nil)
        
        avCtrl.player = player
        player.play()
    }

}
