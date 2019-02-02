
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
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
