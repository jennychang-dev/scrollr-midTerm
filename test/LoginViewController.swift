//
//  LoginViewController.swift
//  test
//
//  Created by Yilei Huang on 2019-01-31.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var infoArray = [info]()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "apple")
        infoArray = [info(userName: "Jenny", password: "123"),
                     info(userName: "Josh", password: "123"),
                     info(userName: "Sam", password: "123"),
        ]

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginButton(_ sender: UIButton) {
        
        for i in 0..<infoArray.count{
            if(infoArray[i].userName == userInput.text){
                if(infoArray[i].passWord == passwordInput.text){
                    performSegue(withIdentifier: "toMain", sender: self)
                }
            }else{
                print("The userName doesn't exist")
            }
        }
       
            
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class info:NSObject{
    var userName = ""
    var passWord = ""
    init(userName:String, password:String) {
        self.userName = userName
        self.passWord = password
    }
}
