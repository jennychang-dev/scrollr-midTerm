
import UIKit
import MobileCoreServices
import MediaPlayer
import AVKit
import Firebase
import FirebaseFirestore

class AccessPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewVideo: UIView!
    

    
    var selectedVideo: URL?
    
    var controller = UIImagePickerController()
    let videoFileName = ".MOV"

    @IBAction func recordVideo(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Video Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        // this removes the previous vid from the screen
        
        self.viewVideo.layer.sublayers = nil
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                imagePickerController.mediaTypes = [kUTTypeMovie as String]
                imagePickerController.delegate = self
                
                self.present(imagePickerController, animated: true, completion: nil)
                
            } else {
                print("camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Video Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            imagePickerController.mediaTypes = ["public.movie"]
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }

    @IBAction func uploadPhoto(_ sender: Any) {
        
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
            
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
            }
            
        // attempting to add a sent pop out but it's currently not working
            let message = "Sent"
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            
            
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
        
        
        // this returns to me a document ID
        
    }
    
    // after I have selected the video
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
            
            self.selectedVideo = selectedVideo
            
            print("here's the file url:\(selectedVideo)")
            
            /// we upload here into video view here
            
            let player =  AVPlayer(url: selectedVideo)
            
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = self.viewVideo.bounds
            self.viewVideo.layer.addSublayer(playerLayer)
            player.play()
            
            // Save video to the main photo album
            let selectorToCall = #selector(self.videoSaved(_:didFinishSavingWithError:context:))
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
            
            // Save the video to the app directory
            let videoData = try? Data(contentsOf: selectedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent(videoFileName)
            try! videoData?.write(to: dataPath, options: [])
        }
        // 3
        picker.dismiss(animated: true)
    }
    
    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("error saving the video = \(theError)")
        } else {
            DispatchQueue.main.async(execute: { () -> Void in
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func tryToPlay(_ sender: Any)
    {
                let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/year%3A%202019%20month%3A%202%20day%3A%201%20hour%3A%2012%20minute%3A%2041%20second%3A%2046%20isLeapMonth%3A%20false%20.MOV?alt=media&token=321a6f67-d011-4764-9a01-b77bcdf14b0b")
        
        
        
        let player = AVPlayer(url: onlineUrl!)
        
        
        let avCtrl = AVPlayerViewController ()
        
        self.present(avCtrl, animated: true, completion: nil)
        
        avCtrl.player = player
        player.play()
        
        }
    
    

}
    
    


