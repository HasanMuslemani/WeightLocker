//
//  WeightTermViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/17/20.
//

import UIKit

class WeightTermViewController: UIViewController {
    
    //MARK: - Properties
    var weightTermTracker: WeightTermTracker!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    //MARK: - Outlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //grab the tab bar controller
        guard let tabBarContr = tabBarController as? TabBarController else {return}
        //set the weight term tracker
        weightTermTracker = tabBarContr.weightTermTracker
        
        if let weightTerm = weightTermTracker.currentWeightTerm {
            
            //create a timer that will run a method when date has passed
            let timer = Timer(fireAt: weightTerm.endDate, interval: 0, target: self, selector: #selector(checkDatePassed), userInfo: nil, repeats: false)
            //add the timer to the main run loop so it goes off
            RunLoop.main.add(timer, forMode: .common)
        }
        
        //add edit as the right bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editWeightTerm))
        
    }
    
    //method will run when edit button is clicked
    //this method will send user to edit weight term view controller and send it weight term tracker
    @objc func editWeightTerm() {
        //grab the add weight term view controller from the storyboard
        let addWeightTermVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "addWeightTerm") as UIViewController
        guard let editWeightTermVC = addWeightTermVC as? AddWeightTermViewController else {return}
        
        editWeightTermVC.weightTermTracker = weightTermTracker
        editWeightTermVC.title = "Edit Weight Term"
        
        
        //go to the edit weight term view controller
        navigationController?.pushViewController(editWeightTermVC, animated: true)
    }
    
    //method will be ran when the weight term end date has passed
    @objc func checkDatePassed() {
        guard let weightTerm = weightTermTracker.currentWeightTerm else {return}
    
        //substract 10 seconds from current date for more accurate checks
        let currentDate = Date().timeIntervalSince1970 - 10
        
        if(currentDate < weightTerm.endDate.timeIntervalSince1970) {
            print("Date passed!!!")
            
            //add the weight term to the in progress list
            weightTermTracker.weightTermsInProgress.append(weightTerm)
            //reset the weight term
            weightTermTracker.currentWeightTerm = nil
            
            //Switch the screen to be the empty weight term screen
            navigationController?.viewControllers[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "emptyWeightTerm") as UIViewController
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let currentWeightTerm = weightTermTracker.currentWeightTerm
        
        guard let weightTerm = currentWeightTerm else {return}
        
        goalLabel.text = String(weightTerm.goalWeight) + " lb"
        weightLabel.text = String(weightTerm.startWeight) + " lb"
        startDateLabel.text = dateFormatter.string(from: weightTerm.startDate)
        endDateLabel.text = dateFormatter.string(from: weightTerm.endDate)
        
    }

}
