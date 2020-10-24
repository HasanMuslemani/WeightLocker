//
//  AddCurrentWeightViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/18/20.
//

import UIKit

class AddCurrentWeightViewController: UIViewController {
    
    //MARK: - Properties
    var weightTermTracker: WeightTermTracker!
    var weightTermIndex: Int!
    var pickerData1: [Int] = []
    var pickerData2: [String] = []
    var pickerValue1 = 150
    var pickerValue2 = 0.2
    
    //MARK: - Outlets
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        //create the data of the picker view
        pickerData1 = Array(stride(from: 0, to: 999, by: 1))
        pickerData2 = [".2", ".4", ".6", ".8"]
        
        //set starting weight in picker view
        weightPicker.selectRow(150, inComponent: 0, animated: false)

    }
    
    //MARK: - Actions
    
    @IBAction func submitClicked(_ sender: Any) {
        //row based on component in weight picker view
        let component1Row = weightPicker.selectedRow(inComponent: 0)
        let component2Row = weightPicker.selectedRow(inComponent: 1)
        
        //grab the value of each row
        pickerValue1 = pickerData1[component1Row]
        pickerValue2 = Double("0\(pickerData2[component2Row])")!
        
        let weight = Double(pickerValue1) + pickerValue2
        
        print("Row: \(weightTermIndex!)")
        
        weightTermTracker.weightTermsInProgress[weightTermIndex].endWeight = weight
        
        let completedWeightTerm = weightTermTracker.weightTermsInProgress[weightTermIndex]
        
        weightTermTracker.allWeightTerms.append(completedWeightTerm)
        
        weightTermTracker.weightTermsInProgress.remove(at: weightTermIndex)
        
        navigationController?.popViewController(animated: true)
            
        }
    
}

//MARK: - Weight Picker Data Source
extension AddCurrentWeightViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //check which component it is
        switch component {
            case 0:
                return pickerData1.count
            case 1:
                return pickerData2.count
            default:
                return 0
        }
    }
    
    
}

//MARK: - Weight Picker Delegate
extension AddCurrentWeightViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //check which component it is
        switch (component) {
            case 0:
                return String(pickerData1[row])
            case 1:
                return pickerData2[row]
            default:
                return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 75
    }
}
