//
//  ScreenActivityActiveLearningViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 15/09/2023.
//

import UIKit

class ScreenActivityActiveLearningViewController: BaseViewController  {
    
    
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var totalRemaingHoursLabel: UILabel!
    
    @IBOutlet weak var timeSpentEntertainment: UITextField!
    @IBOutlet weak var timeSpentLearningGrowth: UITextField!
    @IBOutlet weak var timeSpendMindfulness: UITextField!
    
    let timeSpentEntertainmentPicker = UIDatePicker()
    let timeSpentLearningGrowthPicker = UIDatePicker()
    var timeSpendInMindFullness : Int = 0
    
    var secondsPicker: UIPickerView!
    let secondsArray = Array(1...59)
    
    var age = ""
    var weight = ""
    var height = ""
    
    var total_screen_time = 0
    var emotions = ""
    
    var total_reamining = 0
    var cumulativeValue = 0
    
    var mode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Let’s dig further"
        
        self.total_reamining = self.total_screen_time
        
        print("** Age \(age)")
        print("** weight \(weight)")
        print("** height \(height)")
        print("** total_screen_time \(total_screen_time)")
        print("** emotions \(emotions)")
        
        totalHoursLabel.text = "Total Hours \(total_screen_time)"
        totalRemaingHoursLabel.text = "Remaining Hours \(total_screen_time)"
        
        // Set date picker modes to time
        timeSpentEntertainmentPicker.datePickerMode = .countDownTimer
        timeSpentLearningGrowthPicker.datePickerMode = .countDownTimer
        
        // Create toolbars with "Done" buttons for each picker
        let entertainmentToolbar = createToolbar(for: timeSpentEntertainment, action: #selector(entertainmentDoneButtonTapped))
        let learningGrowthToolbar = createToolbar(for: timeSpentLearningGrowth, action: #selector(learningGrowthDoneButtonTapped))
        let mindfulnessToolbar = createToolbar(for: timeSpendMindfulness, action: #selector(mindfulnessDoneButtonTapped))
        
        // Assign date pickers as input views for text fields
        timeSpentEntertainment.inputView = timeSpentEntertainmentPicker
        timeSpentLearningGrowth.inputView = timeSpentLearningGrowthPicker
        
        // Assign toolbars as the input accessory view for each text field
        timeSpentEntertainment.inputAccessoryView = entertainmentToolbar
        timeSpentLearningGrowth.inputAccessoryView = learningGrowthToolbar
        timeSpendMindfulness.inputAccessoryView = mindfulnessToolbar
        
        // Create and configure the UIPickerView
        secondsPicker = UIPickerView()
        secondsPicker.delegate = self
        secondsPicker.dataSource = self
        
        // Set the UIPickerView as the input view for the UITextField
        timeSpendMindfulness.inputView = secondsPicker
    }
    
    @objc func doneButtonTapped() {
        // Format the selected time and display it in the respective text field
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        timeSpentEntertainment.text = dateFormatter.string(from: timeSpentEntertainmentPicker.date)
        timeSpentLearningGrowth.text = dateFormatter.string(from: timeSpentLearningGrowthPicker.date)
        //timeSpendMindfulness.text = dateFormatter.string(from: timeSpendMindfulnessPicker.date)
        
        // Dismiss the date pickers
        timeSpentEntertainment.resignFirstResponder()
        timeSpentLearningGrowth.resignFirstResponder()
        timeSpendMindfulness.resignFirstResponder()
        
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        
        if timeSpentEntertainment.text == "" {
            showAlert(title: "Error", message: "Enter Time Spend in Entertainment ")
            return
        }
        
        if timeSpentLearningGrowth.text == ""{
            showAlert(title: "Error", message: "Enter time spend in learning and growth engaged in entertainment")
            return
        }
        
        if timeSpendInMindFullness == 0 {
            showAlert(title: "Error", message: "Enter time spent in mindfulness")
            return
        }
        
        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewAssesmentViewController") as? NewAssesmentViewController
        vc?.weight = self.weight
        vc?.height = self.height
        vc?.age = self.age
        vc?.AST = Double(self.total_screen_time)
        vc?.emotions = emotions
        
        vc?.timeSpendInEntertainment = timeSpentEntertainment.text!
        vc?.timeSpendInLearningAndGrowth = timeSpentLearningGrowth.text!
        vc?.timeSpendInMindFilness = String(timeSpendInMindFullness)
        
        vc?.mode = self.mode
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    private func updateCumulativeValue() {
        cumulativeValue = 0
        //        let value1 = Int(activeLGTf.text ?? "") ?? 0
        //        let value2 = Int(activeEngEntTf.text ?? "") ?? 0
        //        let value3 = Int(passEngInLearningTf.text ?? "") ?? 0
        //        let value4 = Int(passiveEngEnterTf.text ?? "") ?? 0
        //
        //        if let value1 = activeLGTf.text, let value1 = Int(value1) {
        //            cumulativeValue += value1
        //            print("cumulativeValue \(cumulativeValue)")
        //        }
        //
        //        if let value2 = activeEngEntTf.text, let value2 = Int(value2) {
        //            cumulativeValue += value2
        //            print("cumulativeValue \(cumulativeValue)")
        //        }
        //
        //        if let value3 = passEngInLearningTf.text, let value3 = Int(value3) {
        //            cumulativeValue += value3
        //            print("cumulativeValue \(cumulativeValue)")
        //        }
        //
        //        if let value4 = passiveEngEnterTf.text, let value3 = Int(value4) {
        //            cumulativeValue += value3
        //            print("cumulativeValue \(cumulativeValue)")
        //        }
        
        //        cumulativeValue = value1 + value2 + value3 + value4
        //        print("cumulativeValue \(value1) \(value2) \(value3) \(value4)")
        
        
    }
    
    func createToolbar(for textField: UITextField, action: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: action)
        toolbar.setItems([doneButton], animated: false)
        return toolbar
    }
    
    @objc func entertainmentDoneButtonTapped() {
        updateTime(for: timeSpentEntertainment, using: timeSpentEntertainmentPicker)
    }
    
    @objc func learningGrowthDoneButtonTapped() {
        updateTime(for: timeSpentLearningGrowth, using: timeSpentLearningGrowthPicker)
    }
    
    @objc func mindfulnessDoneButtonTapped() {
        //        updateTime(for: timeSpendMindfulness, using: timeSpendMindfulnessPicker)
        timeSpendMindfulness.resignFirstResponder()
    }
    
    func updateTime(for textField: UITextField, using datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        textField.text = dateFormatter.string(from: datePicker.date)
        textField.resignFirstResponder()
    }
    
    //    @objc func pickerValueChanged() {
    //        // Extract the selected seconds from the picker
    //        let calendar = Calendar.current
    //        let components = calendar.dateComponents([.second], from: timeSpendMindfulnessPicker.date)
    //        if let selectedSeconds = components.second {
    //            print("Selected Seconds: \(selectedSeconds)")
    //            // You can use the selectedSeconds value as needed in your application.
    //        }
    //    }
    
}


extension ScreenActivityActiveLearningViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // You can validate individual text field input here if needed
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Calculate the new cumulative value when the text field's text changes
        updateCumulativeValue()
        
        // Check if the cumulative value exceeds the maximum
        if cumulativeValue > total_screen_time {
            // You can show an error message or prevent further input here
            // For example, you can display an alert or disable further input
            textField.text = "" // Clear the text field to prevent exceeding the limit
            //            updateRemainingLabel()
        }
        
        // Update the remaining label
        //        updateRemainingLabel()
    }
    
}


extension ScreenActivityActiveLearningViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // We only need one component for seconds
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secondsArray.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(secondsArray[row]) minutes"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSeconds = secondsArray[row]
        timeSpendInMindFullness = selectedSeconds
        timeSpendMindfulness.text = "\(selectedSeconds) minutes"
        // You can use the selectedSeconds value as needed in your application.
    }
    
    
}
