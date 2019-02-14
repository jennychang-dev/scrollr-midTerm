import UIKit
import Firebase
import Foundation
import Firebase
import AVKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource{
    var index = 0
    var urls: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        index = 0
        self.dataSource = self
        self.becomeFirstResponder()
        let view = create()
        setViewControllers([view], direction: .forward, animated: true, completion: nil)
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        print("shaking me")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if (index == 0){
            let view = create()
            return view
            
        } else {
            
            index -= 1
            let view = create()
            return view
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if index == self.urls.count - 1 {
            showToast(message: "End")
            let view = create()
            return view
        } else {
            index += 1
            let view = create()
            return view
        }
    
    }
    
    func create()->UIViewController{
        let acceessPhotoView = AccessPhotoViewController()
        let controller = ViewController()
        
        
        acceessPhotoView.readFireStore { (urls) in
            self.urls = urls
            controller.playVideo(myURL: urls[self.index])
            
        }
        
        return controller
    }
    
    @IBAction func reFreshButton(_ sender: UIBarButtonItem) {
        self.viewDidLoad()
        
    }
    
}

extension PageViewController {
    
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
