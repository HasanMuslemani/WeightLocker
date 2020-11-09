//
//  AddWeightTermViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/12/20.
//

import UIKit

class AddWeightTermViewController: UIViewController {
    
    //MARK: - Properties
    var pickerData1: [Int] = []
    var pickerData2: [String] = []
    var weightTermTracker: WeightTermTracker! //we know its safe since we're setting it before coming to this view controller
    var coreDataManager: CoreDataManager!
    //value of the weight picker for components 1 and 2
    var pickerValue1: Int = 150
    var pickerValue2: Double = 0.2

    //MARK: - Outlets
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set picker view delegate and data source
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        //create the data of the picker view
        pickerData1 = Array(stride(from: 0, to: 999, by: 1))
        pickerData2 = [".2", ".4", ".6", ".8"]
        
        //set starting weight in picker view
        weightPicker.selectRow(150, inComponent: 0, animated: false)
        
        //if there is already a current weight term then we're here to edit so set all values to current values we have stored
        if let currentWeightTerm = weightTermTracker.currentWeightTerm {
            datePicker.date = currentWeightTerm.endDate
            
            //make the weight into a string so we can split it
            let weightString = String(currentWeightTerm.startWeight)
            //split the weight string so we have the int part and decimal part - Example: 150.2 = [150, 2]
            let seperatedString = weightString.components(separatedBy: ".")
            //grab the int part from the weight string and try to cast it into an int otherwise default is 150
            let weightComponent1 = Int(seperatedString[0]) ?? 150
            //grab the decimal part from the weight string and try to cast it into an int otherwise default is 2
            let weightComponent2 = Int(seperatedString[1]) ?? 2
            
            //set the rows of the weight picker in our edit weight term view controller
            weightPicker.selectRow(weightComponent1, inComponent: 0, animated: false)
            weightPicker.selectRow(getWeightPicker2ndRow(decimalWeight: weightComponent2), inComponent: 1, animated: false)
            
        }
        
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
        let startDate = Date()
        let endDate = datePicker.date
        
        var weightTerm = weightTermTracker.currentWeightTerm
        
        if let _ = weightTerm {}
        else {
            weightTerm = WeightTerm(context: coreDataManager.managedContext)
        }
        
        //create the current weight term
        weightTerm!.startWeight = weight
        weightTerm!.endWeight = -1
        weightTerm!.goalWeight = 0
        weightTerm!.startDate = startDate
        weightTerm!.endDate = endDate
        weightTerm!.isCurrent = true
        weightTermTracker.currentWeightTerm = weightTerm
        
        coreDataManager.saveContext()
        
        //switch the navigation controllers root view controller to be the weight term view controller (previously empty weight term view controller)
        navigationController?.viewControllers[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weightTerm") as UIViewController
                                
        navigationController?.popViewController(animated: true)
        
    }
    
    //this method will take in the decimal part of a weight and get which row it's at in the weight picker
    func getWeightPicker2ndRow(decimalWeight: Int) -> Int {
        switch(decimalWeight) {
        case 2:
            return 0
        case 4:
            return 1
        case 6:
            return 2
        case 8:
            return 3
        default:
            return 0
            
        }
    }
    
}

//MARK - Picker View Data Source
extension AddWeightTermViewController: UIPickerViewDataSource {
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

//MARK - Picker View Delegate
extension AddWeightTermViewController: UIPickerViewDelegate {
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

