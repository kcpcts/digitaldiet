//
//  AssesmentView.swift
//  digital_diet
//
//  Created by Taimoor  on 21/09/2023.
//

import SwiftUI
//import GaugeKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseFirestore
import Firebase

struct AssesmentView: View {
    
    @State var title: String
    @State var progressValue: Int
    @State var totalValue: Int
    @State var strap: String
    @State var bodyText: String
    @State var total_screen_time : String
    
    @State var status: String
    @State var range: String
    @State var recomendation : String
    
    @State var mode: String
    
    @State private var isUIKitViewControllerPresented = false
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                
                // GaugeView(title: title, value: progressValue, colors: [.red, .orange, .yellow, .green], additionalInfo: GaugeAdditionalInfo(strap: strap, title: title, body: bodyText)).frame(height: 300)
                
                GaugeView(title: title, value: progressValue, maxValue: totalValue, colors: [.yellow, .green,.red, .red]).frame(height: 250)
                
                Text(status)
                    .font(.title)
                    .padding()
                Text(range)
                    .font(.title)
                    .padding()
                Text(recomendation)
                    .font(.title2)
                    .padding()
                //                Text("Spend more screen time actively engaged or learning!")
                //                    .font(.title2)
                //                    .padding()
                Button(action: {
                    // Action to perform when the button is tapped
                    print("Button tapped!")
                    
                    if let isDailyDairy = UserDefaultsManager.shared.getData(forKey: UserDefaultsStrings.isDailyDairy.rawValue) as? Bool {
                        
                        // Use the retrieved Boolean value here
                        if isDailyDairy == true {
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyyMMdd"
                            let dateString = dateFormatter.string(from: Date())
                            
                            let progressRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "0").collection("progress").document(dateString)
                            
                            let progressData = ["total_screen_time": total_screen_time,"date": Timestamp(date: Date()), "dmi": String(progressValue), "mode": self.mode] as [String : Any]
                            
                            progressRef.setData(progressData) { error in
                                
                                // completion(error)
                                
                                if error == nil {
                                    NotificationCenter.default.post(name: NSNotification.Name("NotificationName"), object: nil)
//                                    isUIKitViewControllerPresented.toggle()
                                }
                            }
                            
                        } else {
                            isUIKitViewControllerPresented.toggle()
                        }
                    } else {
                        isUIKitViewControllerPresented.toggle()
                    }
                    
                }) {
                    
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity) // Make button fill the available width
                        .frame(height: 50) // Set the button's height
                        .background(Color.green)
                        .cornerRadius(10) // Set the button's corner radius
                        .padding(.horizontal, 20) // Add horizontal padding of 20 points
                }
                .padding()
            }
        }
        NavigationLink(
            destination: UIKitViewControllerCoordinator(isPresented: $isUIKitViewControllerPresented)
                .edgesIgnoringSafeArea(.all) // Make it fullscreen
                .navigationBarHidden(true), // Hide the navigation bar
            isActive: $isUIKitViewControllerPresented
        ) {
            EmptyView()
        }
        .hidden()
    }
}

//#Preview {
//    AssesmentView(title: "DI", progressValue: 30, totalValue: 100, strap: "Strap", bodyText: "This is body", total_screen_time: "30",status: "Status",range: "Range", recomendation: "Recomendation",mode: "3")
//}




