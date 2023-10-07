//
//  StoryBoard.swift
//  digital_diet
//
 
//

import Foundation
import UIKit

enum StoryBoard: String {
    case Main = "Main"
    case auth = "Auth"
    case bookingSession = "BookingSession"
    case home = "Home"
    case profile = "Profile"
    case maps = "Maps"
    case estimatedCharging = "EstimatedCharging"
    case generalPurpose = "GeneralPurpose"
    case digitalProfile = "DigitalProfile"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController< T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).identifier
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

