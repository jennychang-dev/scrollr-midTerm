import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.becomeFirstResponder()
        let view = create()
        setViewControllers([view], direction: .forward, animated: true, completion: nil)
    }
    
   override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("shaking me")
        // could we link this up??? 
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let view = create()
        return view
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let view = create()
        return view
    }

    func create()->UIViewController{
        
        let randomNum = Int.random(in: 1...7)
        let controller = ViewController()
        controller.playVideo(num: randomNum)
        return controller
    }

}
