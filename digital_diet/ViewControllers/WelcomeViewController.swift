//
//  WelcomeViewController.swift
//  digital_diet
//
//  Created by Taimoor  on 31/08/2023.
//

import UIKit

class WelcomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func assesmentAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "DairyWeightHeightViewController") as? DairyWeightHeightViewController
                self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    @IBAction func continueAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
//        
//        let vc = UIStoryboard.init(name: "DigitalProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddTargetViewController") as? AddTargetViewController
//               self.navigationController?.pushViewController(vc!, animated: true)
//        
//
    }
}
