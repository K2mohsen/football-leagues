
import Foundation

struct Teams: Codable {
    let season: Season?
    let teams: [Team]?
    let competition: Competition?
}
// MARK: - Team
struct Team: Codable {
    let area: Area?
    let id: Int?
    let name, shortName, tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors, venue: String?
    let runningCompetitions: [Competition]?
    let coach: Coach?
    let squad: [Squad]?
    let lastUpdated: Date?
}
// MARK: - Coach
struct Coach: Codable {
    let id: Int?
    let firstName, lastName, name, dateOfBirth: String?
    let nationality: String?
    let contract: Contract?
}
// MARK: - Contract
struct Contract: Codable {
    let start, until: String?
}
// MARK: - Squad
struct Squad: Codable {
    let id: Int?
    let name: String?
    let position: Position?
    let dateOfBirth: String?
    let nationality: String?
}
enum Position: String, Codable {
    case defence = "Defence"
    case defender = "Defender"
    case empty = ""
    case forward = "Forward"
    case goalkeeper = "Goalkeeper"
    case keeper = "Keeper"
    case midfield = "Midfield"
    case midfielder = "Midfielder"
    case offence = "Offence"
}
// MARK: - Season
struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
    let winner: Winner?
}
// MARK: - Winner
struct Winner: Codable {
    let id: Int?
    let name, shortName, tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors: String?
    let lastUpdated: Date?
}

