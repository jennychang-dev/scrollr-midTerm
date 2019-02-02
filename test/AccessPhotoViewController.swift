
import UIKit
import MobileCoreServices
import MediaPlayer
import AVKit
import Firebase
import FirebaseFirestore

class AccessPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewVideo: UIView!
    
    
    @IBAction func readFB(_ sender: Any) {
        self.readFireStore()
    }
    
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
        
        self.uploadToFirebase()
        
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
            /*
            let selectorToCall = #selector(self.videoSaved(_:didFinishSavingWithError:context:))
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
 */
            
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
        let newRef = Storage.storage()
        let generateURL = newRef.reference().child("20190201_18_00_39.MOV")
        
        let vidName = "20190201_18_00_39"
        
        generateURL.downloadURL { url, error in
            if let error = error {
                // Handle any errors
            } else {
                print("it's worked PLEAAAAAAASEEEEEEE")
                print("\(generateURL)")
   
            }
        }
        
        let onlineUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/shittyvine.appspot.com/o/\(vidName).MOV?alt=media&token=c01ddf89-4fc7-402c-a38e-99e7ba4711ec")
        
        let player = AVPlayer(url: onlineUrl!)
        
        
        let avCtrl = AVPlayerViewController ()
        
        self.present(avCtrl, animated: true, completion: nil)
        
        avCtrl.player = player
        player.play()
        
    }
    
    
    
}




