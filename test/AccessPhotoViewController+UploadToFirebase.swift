//
//  AccessPhotoViewController+UploadToFirebase.swift
//  test
//
//  Created by Test on 01/02/2019.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

extension AccessPhotoViewController
    
{
    func uploadToFirebase() {
        
        print("clicking on upload button")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HH_mm_ss"
        let date = Date()
        let dateString = formatter.string(from: date)
        
        // upload to firebase storage
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        if let localFile = self.selectedVideo {
            
            self.videoName = "\(dateString).MOV"
            let nameRef = storageRef.child(videoName)
            let metadata = StorageMetadata()
            metadata.contentType = "video"
            
            
            let uploadTask = nameRef.putFile(from: localFile, metadata: metadata) { (retMeDarta, retErr) in
                
                print (".\n\n\n\n")
                dump(retMeDarta)
                print (".\n\n\n")
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
        
        self.sendToFireDB(dateString: dateString)
        
    }
        
        // upload to firebase database
    func sendToFireDB(dateString: String) {
        
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("videoData").addDocument(data: [
            
            // send my UID
            "UID": "Jenny",
            // send my current date
            "Date added": dateString,
            
            "Video URL": "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(self.videoName).MOV?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec"
            
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
