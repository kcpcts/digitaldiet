//
//  DairyWeightHeightViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 13/09/2023.
//

import UIKit

class DairyWeightHeightViewController: BaseViewController {
    
    @IBOutlet weak var ageTf: UITextField!
    @IBOutlet weak var weightTf: UITextField!
    @IBOutlet weak var heightTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ageTf.text = "21"
//        weightTf.text = "20"
//        heightTf.text = "20"
        
//        self.title = "Let's start with the basics"
        self.navigationItem.title = "Let's start with the basics"
        self.navigationItem.title = "Your basics"
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if ageTf.text == "" {
            showAlert(title: "Error", message: "Enter Age")
            return
        } else if  weightTf.text == ""{
            showAlert(title: "Error", message: "Enter weight")
            return
        } else if  weightTf.text == ""{
            showAlert(title: "Error", message: "Enter weight")
            return
        }
        
        UserDefaultsManager.shared.saveData(weightTf.text!, forKey: UserDefaultsStrings.weightKey.rawValue)
        UserDefaultsManager.shared.saveData(heightTf.text!, forKey: UserDefaultsStrings.heightKey.rawValue)
        UserDefaultsManager.shared.saveData(ageTf.text!, forKey: UserDefaultsStrings.age.rawValue)
        
        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScreenUsageViewController") as? ScreenUsageViewController
        vc?.weight = weightTf.text!
        vc?.height = heightTf.text!
        vc?.age = ageTf.text!
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
