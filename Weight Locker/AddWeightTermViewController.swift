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
    //value of the weight picker for components 1 and 2
    var pickerValue1: Int = 0
    var pickerValue2: Double = 0.0

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
    }
    
    //MARK: - Actions
    @IBAction func submitClicked(_ sender: Any) {
        let weight = Double(pickerValue1) + pickerValue2
        let startDate = Date()
        let endDate = datePicker.date
        
        //create the current weight term
        weightTermTracker.currentWeightTerm = WeightTerm(startWeight: weight, goalWeight: 0, startDate: startDate, endDate: endDate)
        
        navigationController?.viewControllers[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weightTerm") as UIViewController
        
        //switch the tab controllers weight term screen to be the screen where there is a current weight term (it's currently the empty weight term screen)
        //tabBarController?.viewControllers?[0] = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weightTerm") as UIViewController
        
        //grab the wieght term view controller from the tab controller
      //  guard let weightTermVC = tabBarController?.viewControllers?[0] as? WeightTermViewController else {return}
        
        //send the weight term view controller our weight term tracker
        //weightTermVC.weightTermTracker = weightTermTracker
                        
        navigationController?.popViewController(animated: true)
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //row based on component in picker view
        let component1Row = weightPicker.selectedRow(inComponent: 0)
        let component2Row = weightPicker.selectedRow(inComponent: 1)
        
        //grab the value of each row
        pickerValue1 = pickerData1[component1Row]
        pickerValue2 = Double("0\(pickerData2[component2Row])")!
        
    }
}

