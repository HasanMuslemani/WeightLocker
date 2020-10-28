//
//  AddPhotoViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/24/20.
//

import UIKit

class AddPhotoViewController: UIViewController {

    //MARK: - Properties
    var imagePicker = UIImagePickerController()
    var imageName = ""
    
    //MARK: - Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the image picker delegate to this class
        imagePicker.delegate = self

        //create a tap gesture recognizer that'll run a method when tapped
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        //add the tap to the image view and allow the image to be tapped
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
        //set the picker to open the device's photo library
        imagePicker.sourceType = .photoLibrary
        //allow the photo to be edited
        imagePicker.allowsEditing = true
        //open the photo library
        present(imagePicker, animated: true, completion: nil)
    }

}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //method will run when the user is done with the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //try to grab the image the user chose otherwise exit from method
        guard let image = info[.editedImage] as? UIImage else {return}
        
        //set the image view's image of this class to the image the user chose
        self.image.image = image
        self.image.layer.cornerRadius = 12
        self.image.clipsToBounds = true
        
        //give the image a unique identifer
        imageName = UUID().uuidString
        //full path of the image - user's document directory / image's name
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
         
        //covert image to jpeg data
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        //dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    //will get the URL of the user's document directory
    func getDocumentsDirectory() -> URL {
        //get the url path of the users document directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        //what we want is always going to be the first item in the list
        return paths[0]
    }
}
