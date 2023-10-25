
import Foundation
import Alamofire

var competitionId : Int?
var teamId : Int?
let compURL = "https://api.football-data.org/v4/competitions"
let apiKey = "7e21461aac484b229189d31e2abad0f1"
let headers : HTTPHeaders = [ "X-Auth-Token": apiKey]


   
class APIService{
    // singletone property
    static let shared = APIService()
    // private initializer
    private init () {}
    
    func fetchCompetitions(completion: @escaping ([Competition]?, String?) -> Void) {
        let request = AF.request(compURL, method: .get, headers: headers)
        request.responseDecodable(of: Competitions.self) { response in
            switch response.result {
            case .success(let response):
                completion(response.competitions, nil)
            case .failure(let error) :
                completion(nil, error.errorDescription)
            }
        }
    }
    func fetchTeams(competitionId:Int, completion : @escaping (Teams?, String?) -> Void) {
        let teamsURL = "https://api.football-data.org/v4/competitions/\(competitionId)/teams"
        let request = AF.request(teamsURL , method: .get , headers: headers)
        request.responseDecodable(of: Teams.self) { response in
            switch response.result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error) :
                completion(nil, error.errorDescription)
            }
        }
    }
    func fetchMatches(teamId : Int, completion : @escaping (Matches?, String?) -> Void){
        let URL = "http://api.football-data.org/v4/teams/\(teamId)/matches"
        let request = AF.request(URL, method: .get, headers: headers)
        request.responseDecodable(of: Matches.self) { response in
            switch response.result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error) :
                completion(nil, error.errorDescription)
            }
        }
    }
}


