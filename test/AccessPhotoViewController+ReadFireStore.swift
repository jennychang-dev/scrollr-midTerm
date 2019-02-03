import Foundation
import Firebase


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
                    
                    print(document.data()["Video URL"]!)
                    
                    let videoName = document.data()["Date added"]
                    let videoURL = document.data()["Video URL"]
                    
                    // Create a new video instance
                    let aVideo = Videos(name: videoName as! String, url: videoURL as! String)
                    aVideo.addVideoToMyArray(url: videoURL as! String)
                    
                }
            }
        }
        
    }
    
}
