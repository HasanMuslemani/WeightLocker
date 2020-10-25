//
//  Photo.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/24/20.
//

import Foundation


class Photo {
    var imagePath: String
    var date: Date
    
    init(imagePath: String, date: Date) {
        self.imagePath = imagePath
        self.date = date
    }
}
