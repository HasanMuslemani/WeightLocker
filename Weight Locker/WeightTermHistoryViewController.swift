//
//  WeightTermHistoryViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/18/20.
//

import UIKit

class WeightTermHistoryViewController: UITableViewController {
    
    //MARK: - Properties
    var weightTermTracker: WeightTermTracker!
    var weightTermIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? AddCurrentWeightViewController else {return}
        
        destinationVC.weightTermTracker = weightTermTracker
        destinationVC.weightTermIndex = weightTermIndex
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
            
        } else {
            cell.startDateLabel.text = dateFormatter.string(from: weightTermTracker.allWeightTerms[indexPath.row].startDate)
            cell.endDateLabel.text = dateFormatter.string(from: weightTermTracker.allWeightTerms[indexPath.row].endDate)
            
            let weightTerm = weightTermTracker.allWeightTerms[indexPath.row]
            let weightDifference = weightTerm.endWeight! - weightTerm.startWeight
            
            cell.weightDifferenceLabel.text = String(weightDifference)
            var textColor: UIColor = .gray
            
            if(weightDifference > 0) {
                textColor = .green
            } else if(weightDifference < 0) {
                textColor = .red
            }
            
            cell.weightDifferenceLabel.textColor = textColor
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weightTermIndex = indexPath.row
    }

}
