//
//  DataService.swift
//  digital_diet
//
//  Created by Taimoor  on 22/09/2023.
//

import Firebase // Import Firebase if you're using it for Firestore

class DataService {
    static let shared = DataService() // Create a singleton instance

    private let db = Firestore.firestore() // Initialize Firestore

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
                let totalScreenTime = data["total_screen_time"] as? String
                let date = data["date"] as? Timestamp
                let dmi = data["dmi"] as? String
                var mode = data["mode"] as? String
                let dailyProgress = DailyProgress(total_screen_time: totalScreenTime ?? "-", date: date!.dateValue(), dmi: dmi ?? "-",mode: mode ?? "-")
                progressData.append(dailyProgress)
            }
            completion(progressData, nil)
        }
    }
}
