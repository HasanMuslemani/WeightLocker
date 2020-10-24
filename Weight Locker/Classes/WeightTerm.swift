//
//  WeightTerm.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/10/20.
//

import Foundation

class WeightTerm {
    
    var startWeight: Double
    var endWeight: Double?
    var goalWeight: Double
    var startDate: Date
    var endDate: Date
    
    init(startWeight: Double, goalWeight: Double, startDate: Date, endDate: Date) {
        self.startWeight = startWeight
        self.endWeight = nil
        self.goalWeight = goalWeight
        self.startDate = startDate
        self.endDate = endDate
    }
}
