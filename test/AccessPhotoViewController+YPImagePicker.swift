import Foundation
import YPImagePicker
import UIKit
import AVKit

extension AccessPhotoViewController: YPImagePickerDelegate {
    
    func noPhotos() {
        print("can't find anything!!")
    }
    
    func setUpYPImagePicker() {
        
        let picker = YPImagePicker(configuration: config)
        
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsFilters = true
        config.shouldSaveNewPicturesToAlbum = false
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .video]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        
        config.video.compression = AVAssetExportPresetHighestQuality
        config.video.fileType = .mov
        config.video.recordingTimeLimit = 60.0
        config.video.libraryTimeLimit = 300.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 300.0
        config.video.trimmerMinDuration = 3.0
        
        YPImagePickerConfiguration.shared = config
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let video = items.singleVideo {
 
                let videoURL = video.url
                self.selectedVideo = videoURL
                
                let player =  AVPlayer(url: self.selectedVideo!)
                
                let playerLayer = AVPlayerLayer(player: player)
                
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                playerLayer.frame = self.viewVideo.bounds
                
                self.viewVideo.layer.addSublayer(playerLayer)
                player.play()
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
}
