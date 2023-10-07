//
//  AddTargetViewController.swift
//  digital_diet
//

//

import UIKit
import Firebase

class AddTargetViewController: BaseViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var valueLabel: UILabel!
    
    
    @IBOutlet weak var agetf: UITextField!
    @IBOutlet weak var targetscreentimetf: UITextField!
    @IBOutlet weak var targetNutritiontf: UITextField!
    let firestoreManager = FirestoreManager()
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var segmenaLabel: UILabel!
    
    @IBOutlet weak var emotionSlider: UISegmentedControl!
    @IBOutlet weak var emotionLabel: UILabel!
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var cv: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func emotionSliderAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Exuberant"
        case 1:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Joyful"
        case 2:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Satisfied"
        case 3:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Unhappy, FOMO"
        case 4:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Sad, Doubtful"
        case 5:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "Helpless, Depressed"
        default:
            print(sender.selectedSegmentIndex)
            emotionLabel.text = "waay to much! 😀"
        }
        
    }
    
    
    
    @IBAction func segmentedControlButtonClickAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "zip, nada 😀"
        case 1:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "way less 😎"
        case 2:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "less 😇"
        case 3:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "just right 😵‍💫"
        case 4:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "more than I should’ve 🙄"
        case 5:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "to much! 😣"
        case 6:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "to much! 💀"
        default:
            print(sender.selectedSegmentIndex)
            segmenaLabel.text = "waay to much! 😀"
        }
       if sender.selectedSegmentIndex == 0 {
          print("First Segment Select")
       }
       else {
          print("Second Segment Select")
       }
    }
   
    
    
    @objc func sliderValueChanged(_ slider: ThreeIntervalSlider) {
        print("Selected Interval: \(slider.selectedInterval)")
    }
//
//    @objc func sliderValueChanged(_ slider: UISlider) {
//           updateValueLabel()
//       }
       
//       func updateValueLabel() {
//           valueLabel.text = "Slider Value: \(Int(slider.value))"
//       }
    
    @IBAction func submitAction(_ sender: Any) {
        
        if agetf.text == "" {
            showAlert(title: "Error", message: "Enter age")
            return
        } else if  targetscreentimetf.text == ""{
            showAlert(title: "Error", message: "Enter target screen time")
            return
        } else if  targetNutritiontf.text == ""{
            showAlert(title: "Error", message: "Enter target nutrition")
            return
        }
        
        
        let newData: [String: Any] = [
            "age": agetf.text ?? "",
            "dailyScreenTimeTarget": targetscreentimetf.text ?? "",
            "dailyNutritionCaloriesTarget" : targetNutritiontf.text ?? ""
        ]
        firestoreManager.updateDocumentWithUserID(userID: Auth.auth().currentUser?.uid ?? "0", newData: newData, collectionName: "users", documentID: Auth.auth().currentUser?.uid ?? "0") { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document updated successfully")
                
                let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    
}


class FirestoreManager {
    
    let db = Firestore.firestore()
    
    func updateDocumentWithUserID(userID: String, newData: [String: Any], collectionName: String, documentID: String, completion: @escaping (Error?) -> Void) {
        let documentRef = db.collection(collectionName).document(documentID)
        
        documentRef.updateData(newData) { error in
            completion(error)
        }
    }
}

class ThreeIntervalSlider: UIControl {
    private let trackView = UIView()
    private let thumbView = UIView()
    
    private let intervalCount = 3
    var selectedInterval: Int = 0 {
        didSet {
            setNeedsLayout()
            sendActions(for: .valueChanged)
        }
    }
    
    private let intervalLabels: [String] = ["Low", "Medium", "High"]
    private var labelViews: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        trackView.backgroundColor = .lightGray
        addSubview(trackView)
        
        thumbView.backgroundColor = .green
        addSubview(thumbView)
        
        for label in intervalLabels {
            let labelView = UILabel()
            labelView.text = label
            labelView.textAlignment = .center
            addSubview(labelView)
            labelViews.append(labelView)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let intervalWidth = bounds.width / CGFloat(intervalCount - 1)
        
        trackView.frame = CGRect(x: 0, y: bounds.midY - 2.5, width: bounds.width, height: 5)
        
        for (index, labelView) in labelViews.enumerated() {
            let intervalX = intervalWidth * CGFloat(index)
            labelView.frame = CGRect(x: intervalX, y: 20, width: intervalWidth, height: 20)
        }
        
        let thumbX = intervalWidth * CGFloat(selectedInterval)
        thumbView.frame = CGRect(x: thumbX - 15, y: bounds.midY - 15, width: 30, height: 30)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let intervalWidth = bounds.width / CGFloat(intervalCount - 1)
        let location = gesture.location(in: self)
        
        var interval = Int(round(location.x / intervalWidth))
        interval = max(0, min(interval, intervalCount - 1))
        
        if selectedInterval != interval {
            selectedInterval = interval
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}
