//
//  UserModelManager.swift
//  digital_diet
//
//  Created by Taimoor  on 21/09/2023.
//

import Foundation

class UserModelManager {
    static let shared = UserModelManager()
    
    private var userModel: UserModel?
    
    private init() {
        // Private initializer to ensure a single instance
    }
    
    func setUserModel(_ userModel: UserModel) {
        print("Saved User Model \(userModel)")
        self.userModel = userModel
    }
    
    func getUserModel() -> UserModel? {
        return userModel
    }
}

