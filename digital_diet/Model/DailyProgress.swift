//
//  DailyProgress.swift
//  digital_diet
//

//

import Foundation
import Firebase
import Charts

//struct DailyProgress: Codable {
//    var screenTime: String?
//    var nutrition: String?
//    var timestamp: Timestamp?
//
//    enum CodingKeys: String, CodingKey {
//        case screenTime
//        case nutrition
//        case timestamp
//    }
//
//    init(screenTime: String, nutrition : String, timestamp : Timestamp) {
//        self.screenTime = screenTime
//        self.nutrition = nutrition
//        self.timestamp = timestamp
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        screenTime = try values.decodeIfPresent(String.self, forKey: .screenTime)
//        nutrition = try values.decodeIfPresent(String.self, forKey: .nutrition)
//        timestamp = try values.decodeIfPresent(Timestamp.self, forKey: .timestamp)
//    }
//}

//struct DailyProgress: Codable {
//    var screenTime: String?
//    var nutrition: String?
//    var timestamp: Timestamp?
//
//    enum CodingKeys: String, CodingKey {
//        case screenTime
//        case nutrition
//        case timestamp
//    }
//
//    init(screenTime: String, nutrition: String, timestamp: Timestamp) {
//        self.screenTime = screenTime
//        self.nutrition = nutrition
//        self.timestamp = timestamp
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        screenTime = try values.decodeIfPresent(String.self, forKey: .screenTime)
//        nutrition = try values.decodeIfPresent(String.self, forKey: .nutrition)
//
//        // Decode Unix timestamp and convert to Timestamp
//        if let timeInterval = try? values.decodeIfPresent(TimeInterval.self, forKey: .timestamp) {
//            timestamp = Timestamp(date: Date(timeIntervalSince1970: timeInterval))
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(screenTime, forKey: .screenTime)
//        try container.encode(nutrition, forKey: .nutrition)
//
//        // Convert Timestamp to Unix timestamp (TimeInterval)
//        if let timestamp = timestamp {
//            let timeInterval = timestamp.dateValue().timeIntervalSince1970
//            try container.encode(timeInterval, forKey: .timestamp)
//        }
//    }
//}


struct DailyProgress: Codable {
    let id = UUID()
    var total_screen_time: String?
    var date: Date?
    var dmi: String?
    var mode: String?
    
    enum CodingKeys: String, CodingKey {
        case total_screen_time
        case date
        case id
        case dmi
        case mode
    }
    
    init(total_screen_time: String, date: Date, dmi: String, mode: String) {
        self.total_screen_time = total_screen_time
        self.date = date
        self.dmi = dmi
        self.mode = mode
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        total_screen_time = try values.decodeIfPresent(String.self, forKey: .total_screen_time)
//        dmi = try values.decodeIfPresent(String.self, forKey: .dmi)
//        //date = try values.decodeIfPresent(Timestamp.self, forKey: .date)
//        
//        // Decode Unix timestamp and convert to Timestamp
//        if let dateN = try? values.decodeIfPresent(TimeInterval.self, forKey: .date) {
//            date = Timestamp(date: Date(timeIntervalSince1970: dateN))
//        }
//        
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(total_screen_time, forKey: .total_screen_time)
//        try container.encode(dmi, forKey: .dmi)
//        if let date = date {
//            let timeInterval = date.dateValue().timeIntervalSince1970
//            try container.encode(timeInterval, forKey: .date)
//            
//        }
//    }
    
}
