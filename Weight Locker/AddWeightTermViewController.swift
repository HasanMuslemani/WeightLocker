//
//  AddWeightTermViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/12/20.
//

import UIKit

class AddWeightTermViewController: UIViewController {
    
    var pickerData1: [Int] = []
    var pickerData2: [String] = []

    //MARK: - Outlets
    @IBOutlet weak var weightPicker: UIPickerView!
    
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

}

//MARK - Picker View Data Source
extension AddWeightTermViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
        return 50
    }
}

