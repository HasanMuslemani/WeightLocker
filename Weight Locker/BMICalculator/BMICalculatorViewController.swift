//
//  BMICalculatorViewController.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 11/7/20.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Outlets
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightSegment: UISegmentedControl!
    @IBOutlet weak var weightSegment: UISegmentedControl!
    @IBOutlet weak var resultColour: UIView!
    @IBOutlet weak var resultType: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //give calculate button corner radius
        calculateButton.layer.cornerRadius = 15
        
        //hide results initially
        resultColour.isHidden = true
        resultType.isHidden = true
        resultAmount.isHidden = true

    }
    
    //MARK: - Actions
    @IBAction func calculateBMI(_ sender: Any) {
        //hide the keyboard
        weightInput.resignFirstResponder()
        heightInput.resignFirstResponder()
        //make sure the user gave a number for the height
        guard let height = Double(heightInput.text!)
        else {
            //alert user - invalid input
            showBasicAlert(title: "Invalid Input", message: "Please enter a valid number for the height")
            return
        }
        
        //make sure the user gave a number for the weight
        guard let weight = Double(weightInput.text!)
        else {
            //alert user - invalid input
            showBasicAlert(title: "Invalid Input", message: "Please enter a valid number for the weight")
            return
        }
        var bmi = 0.0
        
        //check if imperial or metric is selected
        if(heightSegment.selectedSegmentIndex == 0) {
            //get the bmi for imperial
            bmi = calculateBMIImperial(height: height, weight: weight)
        } else {
            //get the bmi for metric
            bmi = calculateBMIMetric(height: height, weight: weight)
        }
        
        //show the user their bmi results
        printBMIResults(bmi: bmi)
        
    }
    
    @IBAction func heightTypeChanged(_ sender: Any) {
        //make sure weight and height segmented controllers at same index (0 = imperial vs 1 = metric)
        if(heightSegment.selectedSegmentIndex == 0) {
            weightSegment.selectedSegmentIndex = 0
        } else {
            weightSegment.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func weightTypeChanged(_ sender: Any) {
        //make sure weight and height segmented controllers at same index (0 = imperial vs 1 = metric)
        if(weightSegment.selectedSegmentIndex == 0) {
            heightSegment.selectedSegmentIndex = 0
        } else {
            heightSegment.selectedSegmentIndex = 1
        }
    }
    
    //MARK: - Methods
    
    func showBasicAlert(title: String, message: String) {
        //alert controller to show an alert with title and message
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //cancel action to close the alert
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        //add the cancel action to the alert controller
        ac.addAction(cancelAction)
        
        //show the alert
        present(ac, animated: true)
    }
    
    //calculates the bmi using the imperial formula and returns it
    func calculateBMIImperial(height: Double, weight: Double) -> Double {
        //formula: 703 x weight (lbs) / [height (in)]^2
        return 703 * weight / (height * height)
    }
    
    //calculates the bmi using the metric formula and returns it
    func calculateBMIMetric(height: Double, weight: Double) -> Double {
        //formula: weight (kg) / [height (m)]^2
        //convert height from cm to m
        let meterHeight = height / 100
        return weight / (meterHeight * meterHeight)
    }
    
    //method that will take in a BMI and show the user their results
    func printBMIResults(bmi: Double) {
        let stringBMI = String(format: "%.2f", bmi) //make it 2 decimal places
        //check the bmi and show results respectively
        if(bmi < 18.5) {
            setResultValues(colour: .blue, type: "Underweight", amount: stringBMI)
        } else if(bmi >= 18.5 && bmi <= 24.9) {
            setResultValues(colour: .green, type: "Normal", amount: stringBMI)
        } else if(bmi >= 25 && bmi <= 29.9) {
            setResultValues(colour: .yellow, type: "Overweight", amount: stringBMI)
        } else if(bmi >= 30 && bmi <= 34.9) {
            setResultValues(colour: .orange, type: "Obese", amount: stringBMI)
        } else if(bmi > 35) {
            setResultValues(colour: .red, type: "Extremely Obese", amount: stringBMI)
        }
        
        //show the results
        resultColour.isHidden = false
        resultType.isHidden = false
        resultAmount.isHidden = false
    }
    
    //method that will set the values of the result views
    func setResultValues(colour: UIColor, type: String, amount: String) {
        resultColour.backgroundColor = colour
        resultType.text = type
        resultAmount.text = amount
    }
    
    
}
