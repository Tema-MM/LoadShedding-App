//
//  Status.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/13.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let status = try? JSONDecoder().decode(Status.self, from: jsonData)

//import Foundation
//
//// MARK: - Status
//struct Status: Codable {
//    let status: StatusClass?
//}
//
//// MARK: - StatusClass
//struct StatusClass: Codable {
//    let capetown, eskom: StageDetail?
//}
//
//// MARK: - StageDetail
//struct StageDetail: Codable {
//    let name: String?
//    let nextStages: [NextStage]?
//    let stage, stageUpdated: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case nextStages = "next_stages"
//        case stage
//        case stageUpdated = "stage_updated"
//    }
//}
//
//// MARK: - NextStage
//struct NextStage: Codable {
//    let stage: String?
//    let stageStartTimestamp: String?
//
//    enum CodingKeys: String, CodingKey {
//        case stage
//        case stageStartTimestamp = "stage_start_timestamp"
//    }
//}
