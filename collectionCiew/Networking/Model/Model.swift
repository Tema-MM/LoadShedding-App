//
//  Model.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/16.
//

import Foundation

// MARK: - Status
struct Status: Codable {
    let status: StatusClass?
}

// MARK: - StatusClass
struct StatusClass: Codable {
    let capetown, eskom: StageDetail?
}

// MARK: - StageDetail
struct StageDetail: Codable {
    let name: String?
    let nextStages: [NextStage]?
    let stage, stageUpdated: String?

    enum CodingKeys: String, CodingKey {
        case name
        case nextStages = "next_stages"
        case stage
        case stageUpdated = "stage_updated"
    }
}

// MARK: - NextStage
struct NextStage: Codable {
    let stage: String?
    let stageStartTimestamp: String?

    enum CodingKeys: String, CodingKey {
        case stage
        case stageStartTimestamp = "stage_start_timestamp"
    }
}


// MARK: - AreaInformation
struct AreaInformation: Codable {
    let events: [Event]?
    let info: Info?
    let schedule: Schedule?
}

// MARK: - Event
struct Event: Codable {
    let end: Date?
    let note: String?
    let start: Date?
}

// MARK: - Info
struct Info: Codable {
    let name, region: String?
}

// MARK: - Schedule
struct Schedule: Codable {
    let days: [Day]?
    let source: String?
}

// MARK: - Day
struct Day: Codable {
    let date, name: String?
    let stages: [[String]]?
}


// MARK: - AreasNearby
struct AreasNearby: Codable {
    let areas: [Area]?
}

// MARK: - Area
struct Area: Codable {
    let count: Int?
    let id, name: String?
    let region: Region?
}

enum Region: String, Codable {
    case eskomDirectCityOfJohannesburgGauteng = "Eskom Direct, City of Johannesburg, Gauteng"
    case jhbCityPower = "JHB City Power"
}


// MARK: - AreasSearch
struct AreasSearch: Codable {
    let areas: [Area]?
}


