//
//  WeightTerms.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/16/20.
//

import Foundation

class WeightTermTracker {
    var currentWeightTerm: WeightTerm?
    var allWeightTerms: [WeightTerm]
    var weightTermsInProgress: [WeightTerm]
    
    init() {
        self.currentWeightTerm = nil
        self.allWeightTerms = []
        self.weightTermsInProgress = []
    }
}
