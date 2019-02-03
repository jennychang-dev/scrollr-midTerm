import UIKit
import Firebase
import Foundation
import Firebase
import AVKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource{
    var index = 0
    
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
        
        index += 1
        let view = create()
        return view
    }
    
    func create()->UIViewController{
        let acceessPhotoView = AccessPhotoViewController()
        let controller = ViewController()
        
        
        acceessPhotoView.readFireStore { (urls) in
            
            controller.playVideo(myURL: urls[self.index])
            
        }
        
        return controller
    }
    
    @IBAction func reFreshButton(_ sender: UIBarButtonItem) {
        self.viewDidLoad()
        
    }
}
