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
    @IBAction func logOutAction(sender: AnyObject){}
    
    func logout() {
        // Send a request to log out a user
        PFUser.logOut()
        
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, self.navigationController)
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(SettingsViewController.logout))
        self.navigationItem.setRightBarButtonItem(logoutButton, animated: false)
    
    }
}