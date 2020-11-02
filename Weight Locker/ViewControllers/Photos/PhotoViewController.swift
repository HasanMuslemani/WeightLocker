//
//  PhotoViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 11/2/20.
//

import UIKit

class PhotoViewController: UIViewController {
    
    //MARK: - Properties
    var photo: Photo!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        
        df.dateStyle = .medium
        df.timeStyle = .medium
        
        return df
    }
    
    //MARK: - Oulets
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the image's path - documentDirectory/imageID (using method to grab document directory from the AddPhotoViewController class)
        let imagePath = AddPhotoViewController().getDocumentsDirectory().appendingPathComponent(photo.imageName)
        
        //set the photo image to be the photo's image by creating a new image from our image's path
        photoView.image = UIImage(contentsOfFile: imagePath.path)
        
        //set the date label to the photo's formatted date
        dateLabel.text = dateFormatter.string(from: photo.date)
        
    }
    

}
