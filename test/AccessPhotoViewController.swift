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
        showToast(message: "Sent")
    }
    
}

extension AccessPhotoViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
