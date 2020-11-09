//
//  WeightTerm+CoreDataProperties.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 11/9/20.
//
//

import Foundation
import CoreData


extension WeightTerm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightTerm> {
        return NSFetchRequest<WeightTerm>(entityName: "WeightTerm")
    }

    @NSManaged public var startWeight: Double
    @NSManaged public var endWeight: Double
    @NSManaged public var goalWeight: Double
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var isCurrent: Bool

}

extension WeightTerm : Identifiable {

}
