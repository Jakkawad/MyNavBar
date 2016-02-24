//
//  Page6ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import APAvatarImageView
import MapleBacon
import DynamicColor

class Page6ViewController: UIViewController, FBLoginViewDelegate {

    var fbLoginView : FBLoginView!
    @IBOutlet weak var fbIDTextField : UILabel!
    @IBOutlet weak var fbNameTextField : UILabel!
    @IBOutlet weak var fbUserImageView : APAvatarImageView!

    //*************************************
    // Begin of Facebook Call-Back Methods
    //*************************************
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        print("User Logged In")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        print("User: \(user)")
        print("User ID: \(user.objectID)")
        print("User Name: \(user.name)")
        
        
        self.fbIDTextField.text = user.objectID
        self.fbNameTextField.text = user.name
        
        let fbImageUrl = "https://graph.facebook.com/\(user.objectID)/picture?type=large"
        print(fbImageUrl)
        let imageURL = NSURL(string: fbImageUrl)!
        self.fbUserImageView.setImageWithURL(imageURL, cacheScaled: true)
    }
    
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        print("User Logged Out")
        
        self.fbIDTextField.text = "Facebook ID"
        self.fbNameTextField.text = "Facebook User's Name"
        self.fbUserImageView.image = UIImage(named: "fb_icon.png")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        print("Error: \(handleError.localizedDescription)")
    }
    
    
    
    func createFBLoginBtn(){
        
        self.fbLoginView = FBLoginView()
        // point = the number of pyhsical pixels / screen's size in inches
        self.fbLoginView.frame = CGRectMake(60, 390, 200, 50)
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        self.view.addSubview(self.fbLoginView)
        
        /*
        if let label = view as? UILable {
        
        } else {
        
        }
        */
        for view in self.fbLoginView.subviews {
            if (view is UILabel){
                let label = view as! UILabel
                label.textColor = UIColor.blackColor()
                label.textAlignment = NSTextAlignment.Left
                label.font = UIFont.systemFontOfSize(12.0)
                
            }else if (view is UIButton){
                let button = view as! UIButton
                button.setBackgroundImage(nil, forState: UIControlState.Normal)
                button.setBackgroundImage(nil, forState: UIControlState.Selected)
                button.setBackgroundImage(nil, forState: UIControlState.Highlighted)
            }
        }
        self.view.addSubview(self.fbLoginView)
        
        
        
    }
    
    
    //*************************************
    // End of Facebook Call-Back Methods
    //*************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createFBLoginBtn()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
