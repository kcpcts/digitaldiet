//
//  Bootstrapper.swift


import UIKit
import Foundation

enum AppFlow {
    case onBoarding
    case authentication
    case home
    case editProfile
    case addVehicle
    case main
    case digitalProfile
}

struct Bootstrapper {
    
    var window: UIWindow
    static var instance: Bootstrapper?
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func initialize(_ scene: UIWindowScene) {
        instance = Bootstrapper(window: UIWindow(windowScene: scene))
        Bootstrapper.setupTheLanguage()
        instance!.bootstrap()
    }
    
    mutating func bootstrap() {
        //Decision point to show Onboarding, Login, Home.
        showSetupView()
        window.makeKeyAndVisible()
    }
    
    static func setupTheLanguage() {
    }
}

extension Bootstrapper {
    
    // MARK: - Load Splash
    private func showSetupView() {
        let controller = LoginViewController.instantiate(fromAppStoryboard: .Main)
        self.window.rootViewController = controller
    }
//
//    // MARK: - Load Localization Configuration
    static func loadApplication() {
        DispatchQueue.main.async {
            startAppFlow(withFlow: .digitalProfile)
//            if UserDefaults.standard.hasShownOnBoardingScreens ?? false {
//                startAppFlow(withFlow: .home)
//            }else {
//                UserDefaults.standard.hasShownOnBoardingScreens = true
//                startAppFlow(withFlow: .onBoarding)
//            }
        }
    }

//    // MARK: - Start App Flow
    static func startAppFlow(withFlow: AppFlow) {

        switch withFlow {
        case .main:
            showTargetScreen()
        case .onBoarding:
            showOnboarding()
        case .authentication:
            break
        case .home:
//            showOnboarding()
            showHome()
        case .editProfile:
            break
        case .digitalProfile:
            break
        case .addVehicle:
            break
        }
    }
    
    static func showTargetScreen(){
         guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showTarget()
    }
    
    private func showTarget(){
        let controller = AddTargetViewController.instantiate(fromAppStoryboard: .home)
        let nav = UINavigationController(rootViewController: controller)
        self.window.rootViewController = nav
    }
    
    
    
    static func showOnboarding(){
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showOnboarding()
    }
    
    private func showOnboarding(){
//        let controller = OnboardingVC.instantiate(fromAppStoryboard: .auth)
//        let nav = UINavigationController(rootViewController: controller)
//        self.window.rootViewController = nav
    }
    
    static func showHome(){
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showHome()
    }
    
    private func showHome(){
        let tabbar = CustomTabBarController.instantiate(fromAppStoryboard: .home)
        self.window.rootViewController = tabbar
        self.window.makeKeyAndVisible()
    }
    
}
