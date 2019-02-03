import Foundation
import Firebase
import AVKit

extension AccessPhotoViewController
    
{
    func readFireStore(completion: @escaping (_ urls: [String]) -> Void)
    {

        let databaseRef = Firestore.firestore()
        
        databaseRef.collection("videoData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //var myScreen = [String]()
                for document in querySnapshot!.documents {
                    
                    let videoName = document.data()["Date added"]
                    let videoURL = document.data()["Video URL"]
//
//                    // Create a new video instance
                    let aVideo = Videos(name: videoName as! String, url: videoURL as! String)
                    //self.videos.append(aVideo.videoURL)
                    if self.videos.contains(aVideo.videoURL){
                        print("duplicating")
                        
                    }else{
                        self.videos.append(aVideo.videoURL)
                        print("adding to array")
                    }
                    
                    
                    
                }
                var sortedArray = self.videos
//                for item in self.videos{
//                    let trimmedString = item.trimmingCharacters(in: .whitespacesAndNewlines)
//                    //let convertToInt = Int(trimmedString)
//                    sortedArray.append(trimmedString)
//                }
                sortedArray.sort()
                sortedArray.reverse()
                self.videos = sortedArray
               
                completion(self.videos)
                }
        }
    }
    
    

        
    
    
//    func sortMovie()->[String]{
//
//        for document in self.videos{
//            let videoName = document.data()["Date added"]
//        }
//    }
    func convertToUnique() -> [String] {
        let unique = Array(Set(self.videos))
        print(unique)
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
