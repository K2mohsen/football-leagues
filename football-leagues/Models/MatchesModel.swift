

import Foundation
// MARK: - Matches
struct Matches: Codable {
    let filters: Filters?
    let resultSet: ResultSet?
    let matches: [Match]?
}
// MARK: - Match
struct Match: Codable {
    let area: Area?
    let competition: Competition?
    let season: Season?
    let id: Int?
    let utcDate: String?
    let status: Status?
    let matchday: Int?
    let stage: Stage?
    let lastUpdated: String?
    let homeTeam, awayTeam: Team?
    let score: Score?
    let referees: [Referee]?
}
// MARK: - Referee
struct Referee: Codable {
    let id: Int?
    let name, type, nationality: String?
}
// MARK: - Score
struct Score: Codable {
    let winner: String?
    let duration: Duration?
    let fullTime, halfTime: Time?
}
enum Duration: String, Codable {
    case regular = "REGULAR"
}

// MARK: - Time
struct Time: Codable {
    let home, away: Int?
}
enum Stage: String, Codable {
    case regularSeason = "REGULAR_SEASON"
}

enum Status: String, Codable {
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
    case timed = "TIMED"
}
// MARK: - ResultSet
struct ResultSet: Codable {
    let count: Int?
    let competitions: Competitions?
    let first, last: String?
    let played, wins, draws, losses: Int?
}
