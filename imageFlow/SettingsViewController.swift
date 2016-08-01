//
//  SettingsViewController.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/19/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import UIKit
import Parse 

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var emailIdentifierLabel: UILabel!
    @IBAction func logOutAction(sender: AnyObject){
        
        
    }
    
    func logout() {
        // Send a request to log out a user
        PFUser.logOut()
        
        //        dispatch_async(dispatch_get_main_queue(), { () -> Void in
        let viewController: LogInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
        self.presentViewController(viewController, animated: true) {
            print("login view controller up on screen now, pop settings view controller from stack behind it")
            if let navigationController = self.navigationController {
                let imageViewController = navigationController.viewControllers.first! as! ImageViewController
                imageViewController.imageArray = []
                imageViewController.cellView.reloadData()
                navigationController.popViewControllerAnimated(false)
            }
          

        }
        //        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, self.navigationController)
        
        // Show the current visitor's username
//        if let pUserName = PFUser.currentUser()?["username"] as? String {
//            self.emailIdentifierLabel.text = "@" + pUserName
//            
//        }
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: Selector("logout"))
        
        self.navigationItem.setRightBarButtonItem(logoutButton, animated: false)
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}