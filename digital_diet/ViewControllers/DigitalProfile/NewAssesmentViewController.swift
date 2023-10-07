//
//  NewAssesmentViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 21/09/2023.
//

import UIKit
import SwiftUI
//import GaugeKit

class NewAssesmentViewController: UIViewController {
    
    var age : String?
    var weight : String?
    var height : String?
    
//    var total_screen_time = 0
    var emotions = ""
    
    var active_growing_hours = 0
    var active_entertainment_hours = 0
    
    var passive_growing_hours = 0
    var passive_entertainment_hours = 0
    
    var GI : Double = 0.0
    var BMI : Double = 0.0
    var SGI : Double = 0.0
    
    var AST : Double = 0.0
    var ENT : Double = 0.0
    var GRO : Double = 0.0
    var MND : Double = 0.0
    
    var statusText = ""
    var recomendationText = ""
    var range = ""
    
    var progressValue = Int()
    var totalValue = Int()
    //    var tilte = String()
    
    var mode = ""
    
    var hostingController: UIHostingController<AssesmentView>?
    
    var timeSpendInEntertainment = ""
    var timeSpendInLearningAndGrowth = ""
    var timeSpendInMindFilness = ""
    
    var DMI = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Split the time strings into hours and minutes
        let components1 = timeSpendInEntertainment.components(separatedBy: ":")
        let components2 = timeSpendInLearningAndGrowth.components(separatedBy: ":")
        
        if let hours1 = Int(components1[0]),
           let minutes1 = Int(components1[1]),
           let hours2 = Int(components2[0]),
           let minutes2 = Int(components2[1]) {
            
            // Calculate the total time in seconds from the first two time values
            let ENT = (hours1 * 3600 + minutes1 * 60)
//            let ENT = 4
            let GRO = (hours2 * 3600 + minutes2 * 60)
//            let GRO = 2
            let totalSeconds = ENT + GRO
            
            // Convert the third time value from minutes to seconds
            let MND = (Int(timeSpendInMindFilness) ?? 0) * 60
//            let MND = 0
            
            // Add the third time value in seconds to the total
            let totalTimeInSeconds = ENT + GRO + MND
            let totalTimeInHours = Double(totalTimeInSeconds) / 3600.0
            
            print("** Total seconds: \(totalTimeInSeconds)")
            print("** Total Hours: \(totalTimeInHours)")
            print("** Total Hours: \(totalTimeInHours)")
            
//            AST = 7
            
//            let normalizeENT : Double = Double((Double(ENT) / totalTimeInHours) * Double(AST))
//            let normalizeGRO : Double = Double((Double(GRO) / totalTimeInHours) * Double(AST))
//            let normalizeMND : Double = Double((Double(MND) / totalTimeInHours) * Double(AST))
//            
//            print("** normalizeENT: \(normalizeENT)")
//            print("** normalizeGRO: \(normalizeGRO)")
//            print("** normalizeMND: \(normalizeMND)")
//            
            if let weight = weight, weight != ""  {
                
                // Use unwrappedValue safely within this block
            } else {
                // Handle the case where optionalValue is nil
                self.weight = UserModelManager.shared.getUserModel()?.weight ?? "-"
                self.height = UserModelManager.shared.getUserModel()?.height ?? "-"
                self.age = UserModelManager.shared.getUserModel()?.age ?? "-"
                
            }
                               
            let bmi = calculateBMI(weightInKilograms: Double(weight!)!, heightInMeters: Double(height!)!)
            BMI = bmi
            print("** Your BMI is: \(bmi)")
            
//            BMI = 27.34
            
            let TSTconstant = 1.0
            let TST = TSTconstant + 3 / (1 + exp((BMI - 29.5) / 2))

            print("** TST: \(TST)")
            
            let NENT = (Double(ENT) / ( Double(ENT) + Double(GRO) + Double(MND)) * AST)
            print("** NENT: \(NENT)")
            
            let NGRO = (Double(GRO) / ( Double(ENT) + Double(GRO) + Double(MND)) * AST)
            print("** NGRO: \(NGRO)")
            
            let NMND = (Double(MND) / ( Double(ENT) + Double(GRO) + Double(MND)) * AST)
            print("** NMND: \(NMND)")

            let EST = (NENT * 1.0) + (NGRO * 0.5) + (NMND * -2)
            print("** EST: \(EST)")
            
            let balance = EST - TST
            print("** balance: \(balance)")
            
            let DMI = 2 * (balance) + 24.5
            print("** DMI: \(DMI)")
//            self.DMI = round(10 * DMI) / 10
            
            self.DMI = 17
            
            
            
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name("NotificationName"), object: nil)
        
        self.navigationItem.title = "Today's screen time balance"
        
        
       
        
        
        
     
        
        
//        AST = Double(total_screen_time)
        //        ENT =
        
        
        
        
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
        //        print("** Your DMI is: \(SGI)")
        //
        //        totalValue = 100
        ////        title = "DI"
        //        progressValue = Int(SGI)
        
                switch(DMI){
                case 0..<19:
                    statusText = "Lean"
                    recomendationText = "Spend more time actively learning"
                    range = "Healthy Range: 18.5-24.5"
                case 18..<29:
                    statusText = "Balanced"
                    recomendationText = "Great job!"
                    range = "Healthy Range: 18.5-24.5"
                case 29...:
                    statusText = "Imbalanced"
                    recomendationText = "Reduce screen time by 3+ hours, spend more time actively learning and less in passive entertainment."
                    range = "Healthy Range: 18.5-24.5"
                default:
                    print("other")
                }
        
        
//                let swiftUIView = AssesmentView(title: "DI", progressValue: DMI, totalValue: totalValue)
//                let swiftUIView = AssesmentView(title: "DMI", progressValue: DMI, totalValue: 100, strap: "New Strap", bodyText: "New body", total_screen_time: String(self.total_screen_time))
        
                let swiftUIView = AssesmentView(title: "DMI", progressValue: Int(DMI), totalValue: 50, strap: "New Strap", bodyText: "New body", total_screen_time: String(self.AST), status: self.statusText, range: self.range, recomendation: self.recomendationText,mode: self.mode)
        
                // Wrap the SwiftUI view in a hosting controller
                hostingController = UIHostingController(rootView: swiftUIView)
                // Add as a child view controller
                addChild(hostingController!)
                // Ensure the hosting controller's view has the correct frame
                hostingController!.view.frame = self.view.bounds
                hostingController!.view.translatesAutoresizingMaskIntoConstraints = false
                // Add the hosting controller's view to the current view
                view.addSubview(hostingController!.view)
                // Set up constraints
                NSLayoutConstraint.activate([
                    hostingController!.view.topAnchor.constraint(equalTo: view.topAnchor),
                    hostingController!.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    hostingController!.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    hostingController!.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        
                // Complete adding the child view controller
                hostingController!.didMove(toParent: self)
        //    }
    }
    
    func calculateBMI(weightInKilograms: Double, heightInMeters: Double) -> Double {
        return (weightInKilograms / (heightInMeters * heightInMeters)) * 703
    }
    
    func convertDateStringToTime(_ dateString: String, inputFormat: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = outputFormat
            return timeFormatter.string(from: date)
        }
        
        return nil
    }
    
    @objc func handleNotification(_ notification: Notification) {
        // Handle the notification here
        print("Received Notification from SwiftUI")
        //        hostingController?.willMove(toParent: nil)
        //        hostingController?.view.removeFromSuperview()
        //        hostingController?.removeFromParent()
        
        //        hostingController?.dismiss(animated: true)
        //        self.navigationController?.popToRootViewController(animated: true)
        
        //        if let navigationController = self.navigationController {
        //            if let targetViewController = navigationController.viewControllers.dropLast(2).first {
        //                navigationController.popToViewController(targetViewController, animated: true)
        //            }
        //        }
        self.tabBarController?.selectedIndex = 0
        
    }
    
}

struct UIKitViewControllerCoordinator: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        //        self.navigationController?.pushViewController(vc!, animated: true)
        return vc!
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // You can update the view controller here if needed
    }
}




extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
