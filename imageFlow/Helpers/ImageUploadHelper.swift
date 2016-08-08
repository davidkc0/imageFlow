//
//  ImageUploadHelper.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/21/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import UIKit

typealias ImageUploadHelperCallback = UIImage? -> Void

class ImageUploadHelper : NSObject {
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
    // View controller on which AlertViewController and UIImagePickerController are presented
    weak var viewController: UIViewController!
    var callback: ImageUploadHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: ImageUploadHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
    }
    func showPhotoSourceSelection() {
        
        let alertController = UIAlertController(title: nil, message: "Upload Images", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photos from Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        alertController.addAction(photoLibraryAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
extension ImageUploadHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
