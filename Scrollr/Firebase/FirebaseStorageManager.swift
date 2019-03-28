import Foundation
import Firebase

class FirebaseStorageManager {
    static var videoName: String = ""

    static func uploadToFirebase(selectedVideo: URL?) {
        
        if selectedVideo == nil {
            print("no video selected")
            return
        } else {
            print("clicking on upload button")
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd_HH_mm_ss"
            let date = Date()
            let dateString = formatter.string(from: date)
            
            // upload to firebase storage
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            if let localFile = selectedVideo {
                
                self.videoName = "\(dateString).MOV"
                let nameRef = storageRef.child(videoName)
                let metadata = StorageMetadata()
                metadata.contentType = "video"
                
                let uploadTask = nameRef.putFile(from: localFile, metadata: metadata) { (retMeDarta, retErr) in
                }
                
                print("soon executing next section")
                
                let vidRef = storageRef.child(videoName)
                vidRef.downloadURL { url, error in
                    
                    if let error = error {
                        print("error retrieving gs \(error)")
                    } else {
                        print("SOMETHING HAS WORKED")
                    }
                }
                
                uploadTask.observe(.failure) { snapshot in
                    if let error = snapshot.error as NSError? {
                        
                        print("we reached here")
                        
                        switch (StorageErrorCode(rawValue: error.code)!) {
                        case .objectNotFound:
                            break
                        case .unauthorized:
                            break
                        case .cancelled:
                            break
                        case .unknown:
                            break
                        default:
                            break
                        }
                    }
                }
                
            } else {
                print("errors")
            }
            
            FirebaseDataManager.sendToFireDB(dateString: dateString)
        }
    }
    
}
