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

    //MARK: - Outlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let tabBarContr = tabBarController as? TabBarController else {return}
        weightTermTracker = tabBarContr.weightTermTracker
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       let currentWeightTerm = weightTermTracker.currentWeightTerm
        
        guard let weightTerm = currentWeightTerm else {return}
        
        goalLabel.text = String(weightTerm.goalWeight)
        weightLabel.text = String(weightTerm.startWeight)
        startDateLabel.text = weightTerm.startDate.description
        endDateLabel.text = weightTerm.endDate.description
        
    }

}
