//
//  ScreenUsageViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 13/09/2023.
//

enum EmotionalState: String {
    case exuberant = "Exuberant" // 😄
    case joyful = "Joyful" // 😉
    case satisfied = "Satisfied" // 😊
    case dissatisfied = "Dissatisfied" // 😟
    case unhappy = "Unhappy, FOMO" // 🙁
    case sad = "Sad,Doubtful" // 😕
    case helpless = "Helpless, Depressed" // 😞
    
}

import UIKit
import FirebaseAuth

class ScreenUsageViewController: BaseViewController {
    
    @IBOutlet weak var cv: UIView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet weak var agetf: UITextField!
    @IBOutlet weak var targetscreentimetf: UITextField!
    @IBOutlet weak var targetNutritiontf: UITextField!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var segmenaLabel: UILabel!
    @IBOutlet weak var emotionSlider: UISegmentedControl!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let firestoreManager = FirestoreManager()
    var currentMood: EmotionalState = .exuberant
    
    var age = ""
    var weight = ""
    var height = ""
    
    var total_screen_time = 2
    var mode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("** Age \(age)")
        print("** weight \(weight)")
        print("** height \(height)")
        
        self.navigationItem.title = "How much did you spend on screens today?"
        self.navigationItem.title = "Enter screen time"
//        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 15)!]

    }
    
    
    @IBAction func emotionSliderAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentMood = EmotionalState.exuberant
            emotionLabel.text = currentMood.rawValue
            mode = "3"
            print("** Current mood: \(currentMood.rawValue) Index \(sender.selectedSegmentIndex)")
        case 1:
            currentMood = EmotionalState.joyful
            emotionLabel.text = currentMood.rawValue
            mode = "2"
            print("** Current mood: \(currentMood.rawValue) Index \(sender.selectedSegmentIndex)")
        case 2:
            currentMood = EmotionalState.satisfied
            emotionLabel.text = currentMood.rawValue
            mode = "1"
            print("** Current mood: \(currentMood.rawValue) Index")
        case 3:
            currentMood = EmotionalState.dissatisfied
            emotionLabel.text = currentMood.rawValue
            mode = "-1"
            print("** Current mood: \(currentMood.rawValue) Index")
        case 4:
            currentMood = EmotionalState.unhappy
            emotionLabel.text = currentMood.rawValue
            mode = "-2"
            print("** Current mood: \(currentMood.rawValue) Index")
        case 5:
            currentMood = EmotionalState.sad
            emotionLabel.text = currentMood.rawValue
            mode = "-3"
            print("** Current mood: \(currentMood.rawValue) Index")
        case 6:
            currentMood = EmotionalState.helpless
            emotionLabel.text = currentMood.rawValue
            mode = "-4"
            print("** Current mood: \(currentMood.rawValue) Index")
        default:
            print(sender.selectedSegmentIndex)
        }
        
    }
    
    
    
    @IBAction func segmentedControlButtonClickAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "less 😇"
            total_screen_time = 2
            
        case 1:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "just right 😵‍💫"
            total_screen_time = 4
        case 2:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "more than I should’ve 🙄"
            total_screen_time = 6
        case 3:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "to much! 😣"
            total_screen_time = 8
        case 4:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "to much! 💀"
            total_screen_time = 10
            
        default:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "waay to much! 😀"
        }
    }
    
    
    
    @objc func sliderValueChanged(_ slider: ThreeIntervalSlider) {
        print("Selected Interval: \(slider.selectedInterval)")
    }

    @IBAction func nextAction(_ sender: Any) {
        //
        //        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScreenActivityViewController") as? ScreenActivityViewController
        //        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScreenActivityActiveLearningViewController") as? ScreenActivityActiveLearningViewController
        vc?.weight = self.weight
        vc?.height = self.height
        vc?.age = self.age
        vc?.total_screen_time = self.total_screen_time
//        vc?.total_screen_time = 7
        vc?.emotions = currentMood.rawValue
        vc?.mode = mode
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //    @IBAction func submitAction(_ sender: Any) {
    
    //        if agetf.text == "" {
    //            showAlert(title: "Error", message: "Enter age")
    //            return
    //        } else if  targetscreentimetf.text == ""{
    //            showAlert(title: "Error", message: "Enter target screen time")
    //            return
    //        } else if  targetNutritiontf.text == ""{
    //            showAlert(title: "Error", message: "Enter target nutrition")
    //            return
    //        }
    //
    //
    //        let newData: [String: Any] = [
    //            "age": agetf.text ?? "",
    //            "dailyScreenTimeTarget": targetscreentimetf.text ?? "",
    //            "dailyNutritionCaloriesTarget" : targetNutritiontf.text ?? ""
    //        ]
    //        firestoreManager.updateDocumentWithUserID(userID: Auth.auth().currentUser?.uid ?? "0", newData: newData, collectionName: "users", documentID: Auth.auth().currentUser?.uid ?? "0") { error in
    //            if let error = error {
    //                print("Error updating document: \(error)")
    //            } else {
    //                print("Document updated successfully")
    //
    //                let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController
    //                self.navigationController?.pushViewController(vc!, animated: true)
    //            }
    //        }
    //    }
    
    
}
