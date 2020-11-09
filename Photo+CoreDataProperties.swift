//
//  Photo+CoreDataProperties.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 11/8/20.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var imageName: String
    @NSManaged public var date: Date

}

extension Photo : Identifiable {

}
