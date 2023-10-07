//
//  AssesmentResultViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 13/09/2023.
//

import UIKit
import GaugeSlider


class AssesmentResultViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var v: GaugeSliderView!
    
    var age = ""
    var weight = ""
    var height = ""
    
    var total_screen_time = 0
    var emotions = ""
    //
    //    var active_growing_hours = 0
    //    var active_entertainment_hours = 0
    //
    //    var passive_growing_hours = 0
    //    var passive_entertainment_hours = 0
    
    var timeSpendInEntertainment = 0
    var timeSpendInLearningAndGrowth = 0
    var timeSpendInMindFilness = 0
    
    var ACT : Double = 0.0
    var GRO : Double = 0.0
    var GI : Double = 0.0
    var BMI : Double = 0.0
    var SGI : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        print("** Age \(age)")
        print("** weight \(weight)")
        print("** height \(height)")
        
        print("** total_screen_time \(total_screen_time)")
        print("** emotions \(emotions)")
        
//        print("** active_growing_hours \(active_growing_hours)")
//        print("** active_entertainment_hours \(active_entertainment_hours)")
//        
//        print("** active_growing_hours \(passive_growing_hours)")
//        print("** active_entertainment_hours \(passive_entertainment_hours)")
//        
        //        setGuage()
        
        //        let bmi = calculateBMI(weightInKilograms: weight, heightInMeters: height)
        //        print("Your BMI is: \(bmi)")
        
        let bmi = calculateBMI(weightInKilograms: Double(weight)!, heightInMeters: Double(height)!)
        BMI = bmi
        print("** Your BMI is: \(bmi)")
        
//        ACT = Double((Double(active_growing_hours) + Double(active_entertainment_hours)) / Double(total_screen_time))
//        
//        GRO = Double((Double(active_growing_hours) + Double(passive_growing_hours)) / Double(total_screen_time))
//        
//        GI = ACT * GRO * 10 + (1 - ACT) * GRO * 7 + ACT * (1 - GRO) * 0 + (1 - ACT) * (1 - GRO) * (-10)
//        
//        print("** Your ACT is: \(ACT)")
//        print("** Your GRO is: \(GRO)")
//        print("** Your GI is: \(GI)")
//        
//        SGI = BMI - GI
//        print("** Your SGI is: \(SGI)")
//        
//        setGuage()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func calculateBMI(weightInKilograms: Double, heightInMeters: Double) -> Double {
        return (weightInKilograms / (heightInMeters * heightInMeters)) * 703
    }
    
    
    fileprivate func setGuage() {
        //        let v = GaugeSliderView()
        v.blankPathColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1) //  -> inactive track color
        v.fillPathColor = UIColor(red: 74/255, green: 196/255, blue: 192/255, alpha: 1) //  -> filled track color
        v.indicatorColor = UIColor(red: 94/255, green: 187/255, blue: 169/255, alpha: 1)
        v.unitColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        v.placeholderColor = UIColor(red: 139/255, green: 154/255, blue: 158/255, alpha: 1)
        v.unitIndicatorColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 0.2)
        v.customControlColor = UIColor(red: 47/255, green: 190/255, blue: 169/255, alpha: 1)
        v.unitFont = UIFont.systemFont(ofSize: 67)
        v.placeholderFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        v.unitIndicatorFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        //        v.customControlButtonTitle = "• Auto"
        v.isCustomControlActive = true
        v.customControlButtonVisible = false
        v.placeholder = "SGI"
        v.unit = ""  //  -> change default unit from temperature to anything you like
        v.progress =  SGI //  -> 0..100 a way to say percentage
        //        v.value = SGI
        v.minValue = 0
        v.maxValue = 100
        v.countingMethod = GaugeSliderCountingMethod.easeInOut // -> sliding animation style
        v.delegationMode = .singular
        
        //  -> or .immediate(interval: Int)
        //        v.leftIcon = UIImage(named: "snowIcon")
        //        v.leftIcon = UIImage(systemName: <#T##String#>)
        //        v.rightIcon = UIImage(named: "sunIcon")
        
        //        self.containerView.addSubview(v)
    }
    
}
