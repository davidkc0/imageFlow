//
//  ImageViewController.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/18/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Haneke
import DKImagePickerController

class ImageViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    

    var refreshControl: UIRefreshControl!
    
    var collectionViewLayout: CustomImageFlowLayout!
    var imageArray : [UIImage] = []

    
    
    @IBOutlet weak var cellView: UICollectionView!
    
    @IBAction func addImageButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
// ADD IMAGE.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.08)!
        let imageFile = PFFile(name: "image.jpg", data: imageData)!
        let image = PFObject(className: "Image")
        image["imageFile"] = imageFile
        image["user"] = PFUser.currentUser()
        image.saveInBackgroundWithBlock { (success, error) in
            
            if success {
            let alert = UIAlertView(title: "Upload successful!", message: "" , delegate: self, cancelButtonTitle: "OK")
                alert.show() }
            else {
                let alert = UIAlertView(title: "Upload Error", message: "Please try again." , delegate: self, cancelButtonTitle: "OK")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout = CustomImageFlowLayout()
        cellView.collectionViewLayout = collectionViewLayout
        cellView.backgroundColor = .whiteColor()
        
        //PULL TO REFRESH.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ImageViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        cellView.addSubview(refreshControl)
        self.loadArray()
    }
    
    func refresh(sender:AnyObject) {
        self.loadArray()
    }
   
// LOAD IMAGE
    func loadArray(){
        let userImages = PFQuery(className: "Image")
        userImages.whereKey("user", equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([userImages])
        
        query.includeKey("user")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            
            
            if let result = result {
                for object in result{

                    let imageFromParse = object["imageFile"] as! PFFile
                    imageFromParse.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                        if let data = data {
                            let image = UIImage(data: data, scale: 1.0)!
                            // 3
                            print("image: \(image)")
                            self.imageArray.append(image)
                            print("doublecheck: " + String(self.imageArray))
                        }
                        if self.refreshControl.refreshing
                        {
                            self.refreshControl.endRefreshing()
                        }
                        
                        self.cellView?.reloadData()
                    }
                }
            }

        }
        print("iamgeArray print \(self.imageArray)")
    }
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imageView.image = self.imageArray[indexPath.row]
        print("inhere")
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
        
    }
    

//PASS IMAGE TO DETAIL VIEW.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailView" {
            let destController = segue.destinationViewController as! DetailViewController
            
            let selectedCellIndex = cellView.indexPathsForSelectedItems()
            let realIndex = selectedCellIndex![0]
        
        
            let passedImage = imageArray[realIndex.row]
            print(passedImage)
            print(selectedCellIndex)
            print(realIndex)
            destController.passedImageInDetailView = passedImage
        }
    }
    
   //IF USER NOT LOGGED IN SEND TO LOG IN.
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogInViewController") as UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
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
    @IBAction func unwindToImageViewScreen(segue:UIStoryboardSegue) {
    }
    
}
