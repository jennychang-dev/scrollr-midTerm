
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
    var videoName: String = ""
    
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
            
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}




