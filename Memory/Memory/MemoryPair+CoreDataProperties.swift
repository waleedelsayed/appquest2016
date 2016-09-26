//
//  MemoryPair+CoreDataProperties.swift
//  Memory
//
//  Created by Toni Suter on 16/08/16.
//  Copyright © 2016 Toni Suter. All rights reserved.
//

import Foundation
import CoreData

extension MemoryPair {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoryPair> {
        return NSFetchRequest<MemoryPair>(entityName: "MemoryPair");
    }

    @NSManaged public var imageData1: Data?
    @NSManaged public var text1: String?
    @NSManaged public var imageData2: Data?
    @NSManaged public var text2: String?
    @NSManaged public var creationDate: Date
}
