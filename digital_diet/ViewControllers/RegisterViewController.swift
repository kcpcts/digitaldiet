//
//  RegisterViewController.swift
//  digital_diet
//

//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: BaseViewController {
    
    var age = ""
    var height = ""
    var weight = ""
    
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var confirmpasswordtf: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        nametf.text = "taimoor"
        //        emailtf.text = "taimoorsd@gmail.com"
        //        passwordtf.text = "12345678"
        //        confirmpasswordtf.text = "12345678"
        
        guard let savedHeight = UserDefaultsManager.shared.getData(forKey: UserDefaultsStrings.heightKey.rawValue) as? String else {
            // Handle the case where the data is not available or is not of the expected type
            // You can show an error message, return early, or perform other error-handling logic.
            print("Height \(height)")
            
            return
        }
        
        guard let savedWeight = UserDefaultsManager.shared.getData(forKey: UserDefaultsStrings.weightKey.rawValue) as? String else {
            // Handle the case where the data is not available or is not of the expected type
            // You can show an error message, return early, or perform other error-handling logic.
            print("Weight \(height)")
            
            return
        }
        
        guard let savedAge = UserDefaultsManager.shared.getData(forKey: UserDefaultsStrings.age.rawValue) as? String else {
            // Handle the case where the data is not available or is not of the expected type
            // You can show an error message, return early, or perform other error-handling logic.
            print("Age \(age)")
            
            return
        }
        
        self.height = savedHeight
        self.weight = savedWeight
        self.age = savedAge
    }
    
    fileprivate func register() {
        if nametf.text == "" {
            showAlert(title: "Error", message: "Enter Name")
            return
        } else if  emailtf.text == ""{
            showAlert(title: "Error", message: "Enter Email")
            return
        } else if  passwordtf.text == ""{
            showAlert(title: "Error", message: "Enter Password")
            return
        } else if  confirmpasswordtf.text == ""{
            showAlert(title: "Error", message: "Enter Confirm Password")
            return
        }
        
        
        
        
        self.showCustomLoader()
        // Create firebase user
        Auth.auth().createUser(withEmail: emailtf.text ?? "", password: passwordtf.text ?? "") { authResult, error in
            self.removeCustomLoader()
            if let error = error as NSError? {
                self.showAlert(title: "Error", message: error.localizedDescription)
                //                if let errorCode = AuthErrorCode(rawValue: AuthErrorCode.Code(rawValue: error.code) ?? AuthErrorCode()) {
                //                    switch errorCode {
                //                    case .emailAlreadyInUse:
                //                        self.showAlert(title: "Error", message: "The email address is already in use.")
                //                    case .invalidEmail:
                //                        self.showAlert(title: "Error", message: "Invalid email address.")
                //                    case .weakPassword:
                //                        self.showAlert(title: "Error", message: "Password is too weak. It must be at least 6 characters.")
                //                    default:
                //                        self.showAlert(title: "Error", message: "An error occurred. Please try again later.")
                //                    }
                //                }
                return
            }
            
            // User successfully registered
            if let user = authResult?.user {
                self.createFirestoreUserDocument(for: user) { firestoreError in
                    self.removeCustomLoader()
                    if let firestoreError = firestoreError {
                        // Handle Firestore document creation error
                        self.showAlert(title: "Error", message: firestoreError.localizedDescription)
                    } else {
                        // Firestore document created successfully!
                        // Navigate to the main screen or perform other actions.
                        
                        
                        //                        self.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            
        }
    }
    
    private func createFirestoreUserDocument(for user: User, completion: @escaping (Error?) -> Void) {
        self.showCustomLoader()
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        let userData: [String: Any] = [
            "email": user.email ?? "",
            "name" : nametf.text ?? "",
            "height": height,
            "weight" : weight,
            "age" : age
            // Add more user data here if needed
        ]
        
        userRef.setData(userData) { error in
            self.removeCustomLoader()
            if let error = error {
                print("Error creating user document: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                print("User document created successfully!")
            }
            
            completion(error)
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        register()
    }
    
    
}


