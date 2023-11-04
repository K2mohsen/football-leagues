
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
    let name: String?
    let type: String?
    let emblem: String?
    let code : String?
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
    
    func encodeArea() -> String {
        var encodedString = ""
        if let jsonData = try? JSONEncoder().encode(self),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            encodedString = jsonString
        }
        return encodedString
    }
    
    static func decode(from areaJSON: String) -> Area? {
        var area: Area?
        if let jsonData = areaJSON.data(using: .utf8),
           let decodedArea = try? JSONDecoder().decode(Area.self, from: jsonData) {
            area = decodedArea
        }
        return area
    }
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
    let season: String?
    let competitions, permission: String?
    let limit: Int?
}
