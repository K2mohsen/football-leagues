

import Foundation
import SQLite


class DBManager {
    
    static let shared = DBManager()
    private var db : Connection?
    
    private let competitionsTable = Table("competitions")
    private let id = Expression<Int>("id")
    private let name = Expression<String?>("name")
    private let emblem = Expression<String?>("emblem")
    private let area = Expression<String?>("area")
    private let type = Expression<String?>("type")
    private let code = Expression<String?>("code")
    
    private init () {
        do {
            let dbPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("competitions.sqlite").path
            
            db = try Connection(dbPath)
            try db?.run(competitionsTable.create {table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(emblem)
                table.column(type)
                table.column(area)
                table.column(code)
            })
        }catch {
            print("Error initializing database \(error)")
            //db = nil
        }
    }
    func insert(competition: Competition) {
        do {
            let insert = competitionsTable.insert(
                name <- competition.name,
                emblem <- competition.emblem,
                area <- competition.area?.encodeArea(),
                type <- competition.type,
                type <- competition.code
            )
            try db?.run(insert)
        } catch {
            print("Insertion failed: \(error)")
        }
    }
    func saveToDatabase(competitions : [Competition]) {
        competitions.forEach { Competition in
            insert(competition: Competition)
        }
    }
    func deleteAllCompetitions(){
        do {
        let deleteCompetitions = competitionsTable.delete()
        try db?.run(deleteCompetitions)
        }catch{
            print("failed delete competitions\(error)")
        }
    }
    func fetchCompetitionsFromDatabase () -> [Competition] {
        var competitions : [Competition] = []
        do {
            if let result = try db?.prepare(competitionsTable){
                for row in result {
                    let competition = Competition(
                        id: row[id],
                        area: Area.decode(from: row[area] ?? ""),
                        name: row[name],
                        type: row[type],
                        emblem: row[type],
                        code: row[code]
                    )
                    competitions.append(competition)
                }
            }
        }catch {
            print("fetch Faild \(error)")
        }
        return competitions
    }
}


