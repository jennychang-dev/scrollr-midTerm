import UIKit
import MobileCoreServices
import MediaPlayer
import AVKit
import Firebase
import FirebaseFirestore
import YPImagePicker

class AccessPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedVideo: URL?
    var videoName: String = ""
    var controller = UIImagePickerController()
    let videoFileName = ".MOV"
    
    var config = YPImagePickerConfiguration()
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    @IBAction func loadimagePicker(_ sender: Any) {
        config.screens = [.library, .video]
        config.library.mediaType = .video
        self.setUpYPImagePicker()
    }
    
    @IBOutlet weak var viewVideo: UIView!
    
    @IBAction func readFB(_ sender: Any) {
        self.readFireStore()
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
        self.uploadToFirebase()
    }
    
}
