//
//  LoginViewController.swift
//  digital_diet
//

//

import UIKit
import Firebase

class LoginViewController: BaseViewController {
    
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    var age = ""
    var height = ""
    var weight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextFeild.text = "test@test2.com"
        passwordTextFeild.text = "12345678"
        
        
        //        emailTextFeild.text = "taimoorsd@gmail.com"
        //        passwordTextFeild.text = "12345678"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func login() {
        if emailTextFeild.text == "" {
            showAlert(title: "Error", message: "Enter Email")
            return
        } else if  passwordTextFeild.text == ""{
            showAlert(title: "Error", message: "Enter password")
            return
        }
        
        
        self.showCustomLoader()
        Auth.auth().signIn(withEmail: emailTextFeild.text ?? "", password: passwordTextFeild.text ?? "") { authResult, error in
            
            self.removeCustomLoader()
            if let error = error {
                
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                // User successfully logged in, navigate to the main screen or perform other actions.
                let user = Auth.auth().currentUser
                if let user = user {
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    let uid = user.uid
                    let email = user.email
                    
                    print("UID \(uid) , email \(email)")
                    
                    let db = Firestore.firestore()
                    let collectionReference = db.collection("users")
                    let documentID = Auth.auth().currentUser?.uid ?? "0" // Replace with the actual document ID
                    
                    collectionReference.document(documentID).getDocument { (documentSnapshot, error) in
                        
                        if let error = error {
                            print("Error getting document: \(error)")
                            return
                        }
                        
                        if let documentData = documentSnapshot?.data() {
                            
                            // Handle the document data
                            print("Document data: \(documentData)")
                            
                            
                            do {
                                //                                let userData = docu.data()
                                let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
                                let decoder = JSONDecoder()
                                
                                let user = try decoder.decode(UserModel.self, from: jsonData)
                                
                                print("User email: \(user.email)")
                                print("User name: \(user.name)")
                                print("User age: \(user.age)")
                                print("User dailyNutritionCaloriesTarget: \(user.name)")
                                print("User dailyScreenTimeTarget: \(user.email)")
                                
                                
                                UserModelManager.shared.setUserModel(user)
                                UserDefaultsManager.shared.saveBool(true, forKey: UserDefaultsStrings.isDailyDairy.rawValue)
                                //                                UserDefaults.shared.saveBool(true, forKey: UserDefaultsStrings.isDailyDairy.rawValue)
                                
                                //                                if let dailyNutritionCaloriesTarget = user.dailyNutritionCaloriesTarget {
                                let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController
                                self.navigationController?.pushViewController(vc!, animated: true)
                                //                                } else {
                                //
                                ////                                    let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddTargetViewController") as? AddTargetViewController
                                ////                                    self.navigationController?.pushViewController(vc!, animated: true)
                                //                                }
                            } catch {
                                print("Error decoding user data: \(error)")
                            }
                            
                            
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        login()
    }
    
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as? PrivacyPolicyViewController
        //        self.navigationController?.pushViewController(vc!, animated: true)
        
        let vc = PrivacyPolicyViewController.instantiate(fromAppStoryboard: .Main)
        vc.urlString = "https://www.screennutrition.org/mission"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}


extension LoginViewController {
    
    func fetchAllUsers(excludingUserID: String, completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        let usersCollection = Firestore.firestore().collection("users")
        
        usersCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot {
                let filteredDocuments = snapshot.documents.filter { document in
                    return document.documentID != excludingUserID
                }
                completion(filteredDocuments, nil)
            }
        }
    }
    
}
