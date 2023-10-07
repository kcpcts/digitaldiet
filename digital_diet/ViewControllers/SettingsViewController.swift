//
//  SettingsViewController.swift
//  digital_diet
//
      
//

import UIKit
import FirebaseAuth

class SettingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.settingImage.image = UIImage(systemName: "person")
            cell.settingsLabel.text = "Friends"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.settingImage.image = UIImage(systemName: "trash")
            cell.settingsLabel.text = "Delete Account"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.settingImage.image = UIImage(systemName: "shield")
            cell.settingsLabel.text = "Logout"
            return cell
        default:
            print("DEFAULT")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = FriendsViewController.instantiate(fromAppStoryboard: .home)
            self.navigationController?.pushViewController(vc, animated: false)
        case 1:
//            let vc = PrivacyPolicyViewController.instantiate(fromAppStoryboard: .Main)
//            vc.urlString = "https://www.screennutrition.org/mission"
//            self.navigationController?.pushViewController(vc, animated: false)
//
            createAlert2(title: "Delete Account", message: "Are you sure you want to delete your account? This will permanently erase your account.")
        case 2:
            print("2")
            self.logout()
        default:
            print("3")
        }
    }
    
//    func removeUser() {
        // Assuming you have a reference to the currently authenticated user
        //        if let user = Auth.auth().currentUser {
        //            user.delete { error in
        //                if let error = error {
        //                    // An error occurred while deleting the user
        //                    print("Error deleting user: \(error.localizedDescription)")
        //                } else {
        //                    // User deleted successfully from Firebase Authentication
        //                    print("User deleted successfully.")
        //                    // Continue with removing user data from Firestore
        //                }
        //            }
        //        }
        
       
//    }
    
    func createAlert2 (title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert2.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert2.dismiss(animated: true, completion: nil)
        }))
        alert2.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (action) in
            let user = Auth.auth().currentUser
            user?.delete { error in
                if error != nil {
                    // An error happened.
                } else {
                    // Account deleted.
                    print("user deleted")
                    self.logout()
                }
            }
            //              let controller2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            //              self.present(controller2, animated: true, completion: nil)
        }))
        self.present(alert2, animated: true, completion: nil)
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
            forLogout()
            } catch let err {
                print(err)
        }
    }
    
    
}
