//
//  NewsFeedViewController.swift
//  digital_diet
//

//

struct FeedItem {
    let id: String
    let userID: String
    let text: String
    let timestamp: Timestamp
    let name: String
}

import UIKit
import Firebase

class NewsFeedViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let feedManager = FeedManager()
    var feedsArray = [FeedItem]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        self.navigationItem.title = "Wall"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getNewFeed()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getNewFeed()
        refreshControl.endRefreshing()
        
    }
        
    func getNewFeed() {
        self.feedsArray.removeAll()
        self.showCustomLoader()
        
        feedManager.getFeedItems { feedItems, error in
            
            self.removeCustomLoader()
            if let error = error {
                print("Error fetching feed items: \(error)")
                return
            }
            
            if let feedItems = feedItems {
                for feedItem in feedItems {
                    print("ID: \(feedItem.id), UserID: \(feedItem.userID), Text: \(feedItem.text), Timestamp: \(feedItem.timestamp), User \(feedItem.name)")
                    self.feedsArray.append(feedItem)
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func showTextAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Share Something", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your text"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                print("Entered text: \(text)")
                self.showCustomLoader()
                self.feedManager.addFeedItem(userID: Auth.auth().currentUser?.uid ?? "", text: text) { error in
                    self.removeCustomLoader()
                    if let error = error {
                        print("Adding feed item failed with error: \(error)")
                        
                    } else {
                        print("Feed item added successfully")
                        self.getNewFeed()
                    }
                }
            }
        })
        
        present(alertController, animated: true, completion: nil)
    }
}

extension NewsFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFeedTableViewCell", for: indexPath) as! NewFeedTableViewCell
        cell.newsLabel.text = feedsArray[indexPath.row].text
        cell.userLabel.text = feedsArray[indexPath.row].name
        
        let date = feedsArray[indexPath.row].timestamp.dateValue()
        let formattedDate = formatDate(date, format: "yyyy-MM-dd HH:mm:ss")
        print(formattedDate)
        cell.dateLabel.text = formattedDate
        // cell.dateLabel.text = "\(feedsArray[indexPath.row].timestamp.dateValue())"
        return cell
    }
    
    func formatDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    
}


class FeedManager {
    
    let db = Firestore.firestore()
    
    func addFeedItem(userID: String, text: String, completion: @escaping (Error?) -> Void) {
        let feedCollection = db.collection("feeds")
        let timestamp = Timestamp(date: Date())
        
        let feedItemData: [String: Any] = [
            "userID": userID,
            "text": text,
            "timestamp": timestamp,
            "user"  : UserModelManager.shared.getUserModel()?.name
        ]
        
        feedCollection.addDocument(data: feedItemData) { error in
            if let error = error {
                print("Error adding feed item: \(error)")
                completion(error)
            } else {
                print("Feed item added successfully")
                completion(nil)
            }
        }
    }
    
    func getFeedItems(completion: @escaping ([FeedItem]?, Error?) -> Void) {
        
        let feedCollection = db.collection("feeds")
        
        feedCollection.getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var feedItems: [FeedItem] = []
            
            for document in snapshot?.documents ?? [] {
                
                if let data = document.data() as? [String: Any],  // Corrected line
                   let userID = data["userID"] as? String,
                   let text = data["text"] as? String,
                   let timestamp = data["timestamp"] as? Timestamp,
                   let name = data["user"] as? String
                {
                    
                    let feedItem = FeedItem(id: document.documentID, userID: userID, text: text, timestamp: timestamp, name: name)
                    feedItems.append(feedItem)
                    
                }
            }
            
            completion(feedItems, nil)
        }
    }
}
