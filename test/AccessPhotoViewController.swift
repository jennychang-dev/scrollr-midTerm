import UIKit
import MobileCoreServices
import MediaPlayer
import AVKit
import Firebase
import FirebaseFirestore
import YPImagePicker
import AVFoundation

class AccessPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedVideo: URL?
    var videoName: String = ""
    var controller = UIImagePickerController()
    let videoFileName = ".MOV"
    var videos: [String] = []
    
    var config = YPImagePickerConfiguration()
    
    override func viewDidLoad() {
        super .viewDidLoad()
//        let docRef = db.collection("cities").document("Van")
//        docRef.getDo
    }
    
    @IBAction func loadImagePicker(_ sender: Any) {
        config.screens = [.library, .video]
        config.library.mediaType = .video
        self.setUpYPImagePicker()
    }
    
    
    @IBAction func getUniqueSet(_ sender: Any) {
        self.convertToUnique()
        // use my unique set of urls for scroll vids
    }
    
    @IBOutlet weak var viewVideo: UIView!
    
//    @IBAction func readFB(_ sender: Any) {
//            self.readFireStore()
//    }
    
    @IBAction func uploadVid(_ sender: Any) {
        
        print("executing")
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlayAlertSound(systemSoundID)

        self.uploadToFirebase()
    }
    
    
}
