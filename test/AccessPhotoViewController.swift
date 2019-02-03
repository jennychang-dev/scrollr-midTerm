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
    }
    
    @IBAction func loadImagePicker(_ sender: Any) {
        config.screens = [.library, .video]
        config.library.mediaType = .video
        self.setUpYPImagePicker()
    }
    
    @IBOutlet weak var viewVideo: UIView!
    
    @IBAction func uploadVid(_ sender: Any) {
        
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlayAlertSound(systemSoundID)
        self.uploadToFirebase()
    }
    
}
