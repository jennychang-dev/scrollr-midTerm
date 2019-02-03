import UIKit
import AVKit

class ViewController: UIViewController {

    var player = AVPlayer()
    var infoArray = [String]()
       override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func playVideo(myURL:String) {
    
//        guard let path = Bundle.main.path(forResource: "\(num)", ofType:"mp4") else {
//            debugPrint("video.m4v not found")
//            return
//        }
        let onlineUrl = URL(string: myURL)
        player = AVPlayer(url: onlineUrl!)
//        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = true
        
        addChild(playerController)
        view.addSubview(playerController.view)
        
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let leftAnchor = playerController.view.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightAnchor = playerController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        leftAnchor.constant = -200
        rightAnchor.constant = 200
        
        leftAnchor.isActive = true
        rightAnchor.isActive = true
        
        player.play()

    }

    override func viewWillDisappear(_ animated: Bool) {
        //player.replaceCurrentItem(with: nil)
        player.pause()
    }
    override func viewWillAppear(_ animated: Bool) {
        player.play()
    }
    
}
