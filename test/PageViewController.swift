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
        
//        DispatchQueue.global(qos: .background).async {
//            print("this is run on the background")
//            let videoFunc = AccessPhotoViewController()
//            videoFunc.readFireStore()
//            print(videoFunc.videos)
//           // let docRef = db.coll
////            videoFunc.readFireStore()
////            let info = videoFunc.convertToUnique()
////            print("\(info.count) \n \n \n \n 1111111111")
//
//        }
    }
    
    
   override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("shaking me")
        // could we link this up???
        //let view = create()
    

//    self.pageViewController( viewControllerAfter: view)
//    }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if(index == 0){
            let view = create()
            return view
        }else{
            index = index - 1
            let view = create()
            return view
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        index = index + 1
        let view = create()
        return view
    }

    func create()->UIViewController{
        let acceessPhotoView = AccessPhotoViewController()
        let controller = ViewController()
        
        
        acceessPhotoView.readFireStore { (urls) in
            
            controller.playVideo(myURL: urls[self.index])

        }
        
        
//        controller.playVideo(num: randomNum)
        return controller
    }

    @IBAction func reFreshButton(_ sender: UIBarButtonItem) {
        self.viewDidLoad()
        
    }
}
