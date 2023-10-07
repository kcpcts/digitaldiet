//
//  ScreenActivityPassiveLearningViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 13/09/2023.
//

import UIKit

class ScreenActivityPassiveLearningViewController: BaseViewController {
    
    @IBOutlet weak var passEngInLearningTf: UITextField!
    @IBOutlet weak var passiveEngEnterTf: UITextField!
    
    
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var totalRemaingHoursLabel: UILabel!
    
    var age = ""
    var weight = ""
    var height = ""
    
    var total_screen_time = 0
    var emotions = ""
    
    var active_growing_hours = 0
    var active_entertainment_hours = 0
    
    var passive_growing_hours = 0
    var passive_entertainment_hours = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("** Age \(age)")
        print("** weight \(weight)")
        print("** height \(height)")
        print("** total_screen_time \(total_screen_time)")
        print("** emotions \(emotions)")
        
        print("** active_growing_hours \(active_growing_hours)")
        print("** active_entertainment_hours \(active_entertainment_hours)")
        
        totalHoursLabel.text = "Total Hours \(total_screen_time)"
        totalRemaingHoursLabel.text = "Remaining Hours \(total_screen_time - active_growing_hours - active_entertainment_hours)"

    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        
        if passEngInLearningTf.text == "" {
            showAlert(title: "Error", message: "Enter passively engaged in learning & growing hours")
            return
        } else if passiveEngEnterTf.text == ""{
            showAlert(title: "Error", message: "Enter Passively engaged in entertainment hours")
            return
        }
        
        if (Int(passEngInLearningTf.text!)! + Int(passiveEngEnterTf.text!)!) > (total_screen_time - active_growing_hours - active_entertainment_hours)  {
            print("** Total Active Hourss \(Int(passEngInLearningTf.text!)! + Int(passiveEngEnterTf.text!)!))")
            showAlert(title: "Error", message: "Your actively engagment hours cannot exceed the total hours consumed")
            return
        }
        
       let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "AssesmentResultViewController") as? AssesmentResultViewController
        vc?.weight = self.weight
        vc?.height = self.height
        vc?.age = self.age
        vc?.total_screen_time = self.total_screen_time
        vc?.emotions = emotions
//        vc?.active_growing_hours = active_growing_hours
//        vc?.active_entertainment_hours = active_entertainment_hours
//        
//        vc?.passive_growing_hours = Int(passEngInLearningTf.text!)!
//        vc?.passive_entertainment_hours = Int(passiveEngEnterTf.text!)!
//        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
