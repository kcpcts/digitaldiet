//
//  DashboardViewController.swift
//  digital_diet
//

//

import UIKit
import Charts
import Firebase
import SwiftUI


class DashboardViewController: UIViewController {
    
    let db = Firestore.firestore()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Digital wellness dashboard"
        
        
        // Example value for the bar
        let swiftUIView =   BarChartView(isOverview: true)
        
        // Wrap the SwiftUI view in a hosting controller
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add as a child view controller
        addChild(hostingController)
        
        // Ensure the hosting controller's view has the correct frame
        hostingController.view.frame = self.view.bounds
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller's view to the current view
        view.addSubview(hostingController.view)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Complete adding the child view controller
        hostingController.didMove(toParent: self)
        
//        fetchUpdates()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        
//    }
    
//    fileprivate func fetchUpdates() {
//        fetchDailyProgress(userID: Auth.auth().currentUser?.uid ?? "") { progress, error in
//            
//            guard let progressData = progress else {
//                if let error = error {
//                    print("Error fetching progress data: \(error)")
//                }
//                
//                return
//            }
//            print("** Progress Data \(progressData)")
//        }
//    }
    
    // Helper function to format date to string
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func fetchDailyProgress(userID: String, completion: @escaping ([DailyProgress]?, Error?) -> Void) {
        let progressRef = db.collection("users").document(userID).collection("progress")
        
        progressRef.order(by: "date").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }
            
            var progressData: [DailyProgress] = []
            
            for document in documents {
                let data = document.data()
                let total_screen_time = data["total_screen_time"] as? String
                let date = data["date"] as? Timestamp
                let dmi = data["dmi"] as? String
                let mode = data["mode"] as? String
                
                let dailyProgres = DailyProgress(total_screen_time: total_screen_time ?? "-", date: date!.dateValue(), dmi: dmi ?? "-", mode: mode ?? "-")
                progressData.append(dailyProgres)
            }
            completion(progressData, nil)
        }
    }
    
}
