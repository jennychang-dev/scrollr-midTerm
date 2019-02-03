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
                
                for document in querySnapshot!.documents {
                    
                    let videoName = document.data()["Date added"]
                    let videoURL = document.data()["Video URL"]
                    
                    // Create a new video instance
                    let aVideo = Videos(name: videoName as! String, url: videoURL as! String)
                    
                    if self.videos.contains(aVideo.videoURL){
                        // do nothing
                    } else {
                        self.videos.append(aVideo.videoURL)
                    }
                    
                }
                var sortedArray = self.videos
                
                sortedArray.sort()
                sortedArray.reverse()
                self.videos = sortedArray
                
                completion(self.videos)
            }
        }
    }
    
}
