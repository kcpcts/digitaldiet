//
//  DairyViewController.swift
//  digital_diet
//

//


import UIKit
import Firebase

class DairyViewController: BaseViewController {
    
    @IBOutlet weak var screenTimetf: UITextField!
    @IBOutlet weak var nutritiontf: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Daily Dairy"
    }
    
    @IBAction func submitAction(_ sender: Any) {
        if screenTimetf.text == "" {
            showAlert(title: "Error", message: "Enter age")
            return
        } else if  nutritiontf.text == ""{
            showAlert(title: "Error", message: "Enter target screen time")
            return
        }
        
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyyMMdd"
        //        let dateString = dateFormatter.string(from: Date())
        
        logDailyProgress(userID: Auth.auth().currentUser?.uid ?? "0", screenTime: "120", nutrition: "20", date: Date()) { error in
            
            print(error?.localizedDescription)
        }
        
    }
    
    func logDailyProgress(userID: String, screenTime: String, nutrition: String, date: Date, completion: @escaping (Error?) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        
        let progressRef = db.collection("users").document(userID).collection("progress").document(dateString)
        
        let progressData = ["screenTime": screenTime, "nutrition": nutrition, "date": Timestamp(date: Date())] as [String : Any]
        
        progressRef.setData(progressData) { error in
            
            completion(error)
        }
        
    }
    
}
