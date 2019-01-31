//
//  ReusableViewController.swift
//  test
//
//  Created by Yilei Huang on 2019-01-30.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//
//
//import UIKit
//
//class ReusableViewController: UIViewController {
//        @IBOutlet weak var containerView: UIView!
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            addReusableViewController()
//        }
//
//        func addReusableViewController() {
//            guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: ReusableViewController.self)) as? ReusableViewController else { return }
//            vc.willMove(toParentViewController: self)
//            addChildViewController(vc)
//            containerView.addSubview(vc.view)
//            constraintViewEqual(view1: containerView, view2: vc.view)
//            vc.didMove(toParentViewController: self)
//        }

//        /// Sticks child view (view1) to the parent view (view2) using constraints.
//        private func constraintViewEqual(view1: UIView, view2: UIView) {
//            view2.translatesAutoresizingMaskIntoConstraints = false
//            let constraint1 = NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
//            let constraint2 = NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
//            let constraint3 = NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
//            let constraint4 = NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
//            view1.addConstraints([constraint1, constraint2, constraint3, constraint4])
//        }
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
