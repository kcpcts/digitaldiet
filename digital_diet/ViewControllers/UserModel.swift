//
//  UserModel.swift
//  digital_diet
//
 
//

import Foundation

struct UserModel: Codable {
    let email: String?
    let name: String?
    let age : String?
    let height : String?
    var weight: String?
    let dailyNutritionCaloriesTarget : String?
    let dailyScreenTimeTarget : String?
    let progress: [Date: DailyProgress]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case age
        case dailyNutritionCaloriesTarget
        case dailyScreenTimeTarget
        case progress
        case weight
        case height
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        dailyNutritionCaloriesTarget = try values.decodeIfPresent(String.self, forKey: .dailyNutritionCaloriesTarget)
        dailyScreenTimeTarget = try values.decodeIfPresent(String.self, forKey: .dailyScreenTimeTarget)
        progress = try values.decodeIfPresent([Date: DailyProgress].self, forKey: .progress)
        
    }
}
