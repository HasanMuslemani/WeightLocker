//
//  WeightTermHistoryViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/18/20.
//

import UIKit
import CoreData

class WeightTermHistoryViewController: UITableViewController {
    
    //MARK: - Properties
    var weightTermTracker: WeightTermTracker!
    var coreDataManager: CoreDataManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get our custom tab bar controller
        guard let tabBarContr = tabBarController as? TabBarController else {return}
        coreDataManager = tabBarContr.coreDataManager

        //fetch all the weight terms from core data context
        coreDataManager.fetchWeightTerms(weightTermTracker: weightTermTracker)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    //MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the view controller we're going to
        guard let destinationVC = segue.destination as? AddCurrentWeightViewController else {return}
        
        //pass the values to the new view controller
        destinationVC.weightTermTracker = weightTermTracker
        destinationVC.coreDataManager = coreDataManager
        
        let index = tableView.indexPathForSelectedRow?.row
        destinationVC.weightTermIndex = index
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //get the index path for the row clicked
        guard let indexPath = tableView.indexPathForSelectedRow else { return true }
        
        //check which section the row clicked is in
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return weightTermTracker.weightTermsInProgress.count
        case 1:
            return weightTermTracker.allWeightTerms.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Pending Completion"
        case 1:
            return "Previous Terms"
        default:
            return ""
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightTermCell", for: indexPath) as! WeightTermCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if(indexPath.section == 0) {
            cell.startDateLabel.text = dateFormatter.string(from: weightTermTracker.weightTermsInProgress[indexPath.row].startDate)
            cell.endDateLabel.text = dateFormatter.string(from: weightTermTracker.weightTermsInProgress[indexPath.row].endDate)
            cell.weightDifferenceLabel.text = "---"
            cell.weightDifferenceLabel.textColor = .gray
            
        } else {
            cell.startDateLabel.text = dateFormatter.string(from: weightTermTracker.allWeightTerms[indexPath.row].startDate)
            cell.endDateLabel.text = dateFormatter.string(from: weightTermTracker.allWeightTerms[indexPath.row].endDate)
            
            let weightTerm = weightTermTracker.allWeightTerms[indexPath.row]
            let weightDifference = weightTerm.endWeight - weightTerm.startWeight
            
            cell.weightDifferenceLabel.text = String(format: "%.1f", weightDifference) + " lb"
            var textColor: UIColor = .gray
            
            if(weightDifference > 0) {
                cell.weightDifferenceLabel.text = "+" + cell.weightDifferenceLabel.text!
                textColor = .red
            } else if(weightDifference < 0) {
                textColor = .systemGreen
            }
            
            cell.weightDifferenceLabel.textColor = textColor
            
        }
        
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.7, delay: 0.05 * Double(indexPath.row)) {
            cell.alpha = 1.0
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //swipe to delete
        if(editingStyle == .delete) {
            //check if its weight term in progress or a completed weight term
            if(indexPath.section == 0) {
                //delete the weight term from the core data context
                let weightTermToDelete = weightTermTracker.weightTermsInProgress[indexPath.row]
                coreDataManager.managedContext.delete(weightTermToDelete)
                coreDataManager.saveContext()
                
                //remove the weight term from the table view and tracker
                weightTermTracker.weightTermsInProgress.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if(indexPath.section == 1) {
                //delete the weight term from the core data context
                let weightTermToDelete = weightTermTracker.allWeightTerms[indexPath.row]
                coreDataManager.managedContext.delete(weightTermToDelete)
                coreDataManager.saveContext()
                
                //remove the weight term from the table view and tracker
                weightTermTracker.allWeightTerms.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}
