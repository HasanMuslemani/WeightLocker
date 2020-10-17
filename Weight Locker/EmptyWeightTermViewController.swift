//
//  ViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/10/20.
//

import UIKit

class EmptyWeightTermViewController: UIViewController {
    
    //tabBarController?.viewControllers?[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weightTerm") as UIViewController
    
    //MARK: - Properties
    var weightTermTracker: WeightTermTracker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let tabBarContr = tabBarController as? TabBarController else {return}
        weightTermTracker = tabBarContr.weightTermTracker
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //make sure the destination is the add weight term view controller
        guard let addWeightTermVC = segue.destination as? AddWeightTermViewController else {return}
        
        //send the weight term tracker to the add weight term view controller
        addWeightTermVC.weightTermTracker = weightTermTracker
    }


}

