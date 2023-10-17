
import Foundation

// MARK: - Welcome
struct Competitions: Codable {
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
    let lastUpdated: String?
}
enum Code: String, Codable {
    case ecq = "ECQ"
    case qafc = "QAFC"
    case qcbl = "QCBL"
    case wc = "WC"
}
enum Name: String, Codable {
    case europeanChampionshipQualifiers = "European Championship Qualifiers"
    case fifaWorldCup = "FIFA World Cup"
    case wcQualificationAFC = "WC Qualification AFC"
    case wcQualificationCONMEBOL = "WC Qualification CONMEBOL"
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
