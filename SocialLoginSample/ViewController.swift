//
//  ViewController.swift
//  SocialLoginSample
//
//  Created by Masuhara on 2017/09/15.
//  Copyright © 2017年 Ylab, Inc. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    var dict : [String : AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookLogin() {
        
        if FBSDKAccessToken.current() != nil {
            print(FBSDKAccessToken.current())
        }
        
        let manager = FBSDKLoginManager()
        // "public_profile", "email", "user_friends"
        manager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let result = result {
                    if result.grantedPermissions != nil {
                         if result.grantedPermissions.contains("email") == true {
                            self.getFBUserData()
                            manager.logOut()
                        }
                    }
                }
            }
        }

    }
    
    func getFBUserData(){
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if error == nil {
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }

}

