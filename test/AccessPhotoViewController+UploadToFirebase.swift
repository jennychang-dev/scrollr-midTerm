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
        
        let currentDateTime = Date()
        let userCal = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        let dateTimeComponents = userCal.dateComponents(requestedComponents, from: currentDateTime)
        
        // upload to firebase storage
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        if let localFile = self.selectedVideo {
            let videoName = "\(dateTimeComponents).MOV"
            let nameRef = storageRef.child(videoName)
            let metadata = StorageMetadata()
            metadata.contentType = "video"
            
            let uploadTask = nameRef.putFile(from: localFile, metadata: metadata)
            
            uploadTask.observe(.failure) { snapshot in
                if let error = snapshot.error as NSError? {
                    switch (StorageErrorCode(rawValue: error.code)!) {
                    case .objectNotFound:
                        // File doesn't exist
                        break
                    case .unauthorized:
                        // User doesn't have permission to access file
                        break
                    case .cancelled:
                        // User canceled the upload
                        break
                    case .unknown:
                        // Unknown error occurred, inspect the server response
                        break
                    default:
                        // A separate error occurred. This is a good place to retry the upload.
                        break
                    }
                }
            }
            
        } else {
            print("errors")
        }
        
        // upload to firebase database
        
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("videoData").addDocument(data: [
            
            // send my UID
            "UID": "Newj",
            // send my current date
            "Date added": Timestamp(date: currentDateTime),
            
            "Video URL": "\(selectedVideo!)"
            
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
