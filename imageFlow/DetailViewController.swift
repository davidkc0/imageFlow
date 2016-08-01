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
    
    var passedImageInDetailView: UIImage?
    
    var photoPassed : UIImageView = UIImageView()
    
    var post: PFObject!
    
    
    //PASS IMAGE FROM ImageViewController TO DetailView.
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = passedImageInDetailView
    }

    
    //DOWNLOAD BACK TO LOCAL PHOTO LIBRARY.
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(detailImage.image!, self, #selector(DetailViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //PRESENT ALART WHEN IMAGE IS SAVED OR ERROR.
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to your local photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
