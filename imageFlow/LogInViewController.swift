//
//  LogInViewController.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/19/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginAction(sender: AnyObject) {
        var username = self.emailField.text
        var password = self.passwordField.text
        
        // Validate the text fields
        if (username?.utf16.count < 8) {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if (password?.utf16.count < 8) {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ImageViewController") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
}
