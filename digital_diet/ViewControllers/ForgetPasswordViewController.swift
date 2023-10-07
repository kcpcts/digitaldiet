//
//  ForgetPasswordViewController.swift
//  digital_diet
//

//

import UIKit
import FirebaseAuth
import Toast

class ForgetPasswordViewController: BaseViewController {
    
    @IBOutlet weak var emailtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    fileprivate func sendCode() {
        if emailtf.text == "" {
            showAlert(title: "Error", message: "Enter Email")
            return
        }
        self.showCustomLoader()
        Auth.auth().sendPasswordReset(withEmail: emailtf.text ?? "") { error in
            
            self.removeCustomLoader()
            if let error = error {
                
                //                self.showAlert(title: "Error", message: error.localizedDescription)
                let toast = Toast.text(error.localizedDescription)
            } else {
                //                self.showAlert(title: "Success", message: "Password reset email sent. Check your inbox.")
                let toast = Toast.text("Password reset email sent. Check your inbox.")
                toast.show()
                self.navigationController?.popViewController(animated: true)
                
            }
        }
        
        
        
    }
    
    @IBAction func sendCodeAction(_ sender: Any) {
        sendCode()
    }
    
}
