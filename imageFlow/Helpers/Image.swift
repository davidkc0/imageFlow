//
//  Image.swift
//  imageFlow
//
//  Created by David Ciaffoni on 7/25/16.
//  Copyright © 2016 David Ciaffoni. All rights reserved.
//

import Foundation
import Parse

class Image : PFObject, PFSubclassing {
    
//    var image: UIImage
//    var imageUploadtask: UIBackgroundTaskIdentifier?
//    @NSManaged var imageFile: PFFile?
//    @NSManaged var user: PFUser?
    
    override init() {
        //nothing
        super.init()
    }
    
    static func parseClassName() -> String {
        return "Image"

    }
    
    
    
    
    
    
}
