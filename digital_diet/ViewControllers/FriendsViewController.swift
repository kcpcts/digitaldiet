//
//  FriendsViewController.swift
//  digital_diet
//
 
//






import UIKit
import Firebase
import FirebaseFirestore

class FriendsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Users"
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        callAPI()
    }
    
    fileprivate func callAPI() {
        showCustomLoader()
        fetchAllUsers(excludingUserID: Auth.auth().currentUser?.uid ?? "0") { (documents, error) in
            self.removeCustomLoader()
            if let error = error {
                // Handle error
            } else if let documents = documents {
                for document in documents {
                    do {
                        let userData = document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(UserModel.self, from: jsonData)
                        
                        print("User email: \(user.email)")
                        print("User name: \(user.name)")
                        print("User age: \(user.age)")
                        print("User dailyNutritionCaloriesTarget: \(user.name)")
                        print("User dailyScreenTimeTarget: \(user.email)")
                        
                        self.users.append(user)
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
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


extension FriendsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        // cell.settingImage.image = UIImage(systemName: "person")
        cell.settingsLabel.text = users[indexPath.row].name
        
        cell.buttonTappedHandler = {
            print("Button tapped in cell at index: \(indexPath.row)")
            self.showAlert(title: "Add as a friend", message: "Do you want to be friend with \(self.users[indexPath.row].name)?")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       
    }
}
