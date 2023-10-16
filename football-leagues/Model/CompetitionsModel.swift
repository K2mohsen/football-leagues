
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let count: Int?
    let filters: Filters?
    let competitions: [Competition]?
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name, code: String?
    let type: TypeEnum?
    let emblem: String?
    let plan: Plan?
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: Date?
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name, code: String?
    let flag: String?
}

// MARK: - CurrentSeason
struct CurrentSeason: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}

enum Plan: String, Codable {
    case tierOne = "TIER_ONE"
}

enum TypeEnum: String, Codable {
    case cup = "CUP"
    case league = "LEAGUE"
}

// MARK: - Filters
struct Filters: Codable {
    let client: String?
}
