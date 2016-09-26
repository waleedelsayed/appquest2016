//
//  MemoryPair+CoreDataClass.swift
//  Memory
//
//  Created by Toni Suter on 16/08/16.
//  Copyright © 2016 Toni Suter. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class MemoryPair: NSManagedObject {
    var image1: UIImage? {
        get {
            if let data = imageData1 {
                return UIImage(data: data)
            } else {
                return nil
            }
        }
        
        set {
            if let img = newValue {
                self.imageData1 = UIImageJPEGRepresentation(img, 1.0)
            } else {
                self.imageData1 = nil
            }
        }
    }
    
    var image2: UIImage? {
        get {
            if let data = imageData2 {
                return UIImage(data: data)
            } else {
                return nil
            }
        }
        
        set {
            if let img = newValue {
                self.imageData2 = UIImageJPEGRepresentation(img, 1.0)
            } else {
                self.imageData2 = nil
            }
        }
    }
}
