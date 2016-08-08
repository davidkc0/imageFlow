//
//  DetailViewController.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/20/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detailImage: UIImageView!
    
    var passedImageInDetailView = UIImage?()
    
    var photoPassed : UIImageView = UIImageView()
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = passedImageInDetailView

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
