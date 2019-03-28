import Foundation
import Firebase

class FirebaseDataManager {
    
    static func sendToFireDB(dateString: String) {
        
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("videoData").addDocument(data: [
            
            // send my UID
            "UID": "Jenny",
            "Date added": dateString,
            "Video URL": "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(dateString).MOV?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec"
            ])
            
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
}
