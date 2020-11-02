//
//  PhotosTableViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/24/20.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    
    //MARK: - Properties
    var photoTracker: PhotoTracker!

    override func viewDidLoad() {
        super.viewDidLoad()

        //get the tab bar controller
        guard let tabBarContr = tabBarController as? TabBarController else {return}
        
        photoTracker = tabBarContr.photoTracker
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addPhoto") {
            guard let addPhotoVC = segue.destination as? AddPhotoViewController else {return}
            
            //pass the photo tracker to the add photo view controller
            addPhotoVC.photoTracker = photoTracker
        } else if(segue.identifier == "viewPhoto") {
            guard let photoVC = segue.destination as? PhotoViewController else {return}
            
            //pass the photo to the photo view controller
            if let row = tableView.indexPathForSelectedRow?.row {
                photoVC.photo = photoTracker.photos[row]
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoTracker.photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else {
            fatalError("Unable to dequeue Photo cell")
        }

        //grab the photos list from the photo tracker
        let photos = photoTracker.photos
        //get the current photo in the list
        let photo = photos[indexPath.row]
        
        //create a date formatter
        var dateFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateStyle = .medium
            return df
        }
        
        //set the date label to the photos formatted date
        cell.dateLabel.text = dateFormatter.string(from: photo.date)
        
        //get the image's path - documentDirectory/imageID (using method to grab document directory from the AddPhotoViewController class)
        let imagePath = AddPhotoViewController().getDocumentsDirectory().appendingPathComponent(photo.imageName)
        
        //set the cell's image to be the photo's image by creating a new image from our image's path
        cell.photo.image = UIImage(contentsOfFile: imagePath.path)
        cell.photo.layer.cornerRadius = 3

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

}
