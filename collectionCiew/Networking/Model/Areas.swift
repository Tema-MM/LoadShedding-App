// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let areas = try? JSONDecoder().decode(Areas.self, from: jsonData)

//import Foundation
//
//// MARK: - Areas
//struct Areas: Codable {
//    let events: [Event]?
//    let info: Info?
//    let schedule: Schedule?
//}
//
//// MARK: - Event
//struct Event: Codable {
//    let end: Date?
//    let note: String?
//    let start: Date?
//}
//
//// MARK: - Info
//struct Info: Codable {
//    let name, region: String?
//}
//
//// MARK: - Schedule
//struct Schedule: Codable {
//    let days: [Day]?
//    let source: String?
//}
//
//// MARK: - Day
//struct Day: Codable {
//    let date, name: String?
//    let stages: [[String]]?
//}
