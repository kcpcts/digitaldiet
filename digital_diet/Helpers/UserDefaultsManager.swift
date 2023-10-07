
enum UserDefaultsStrings: String {
    case weightKey = "weigth"
    case heightKey = "height"
    case age = "age"
    case isDailyDairy = "isDailyDairy"
}

import Foundation

struct UserDefaultsManager {
    static let shared = UserDefaultsManager() // Singleton instance
    
//    let weightKey = "weigth"
//    let heightKey = "height"
//    let age = "age"
//    let isDailyDairy = "isDailyDairy"

    // MARK: - Save Data to UserDefaults

    func saveData(_ value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    // MARK: - Retrieve Data from UserDefaults

    func getData(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func saveBool(_ value: Bool, forKey key: String) {
           UserDefaults.standard.set(value, forKey: key)
    }

    // MARK: - Remove Data from UserDefaults

    func removeData(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
