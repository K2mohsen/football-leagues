
import Foundation
import Alamofire

let compURL = "https://api.football-data.org/v4/competitions"
let teamsURL = "http://api.football-data.org/v4/competitions/WC/teams"
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
               // print("error fetching data :\(error)")
                completion(nil, error.errorDescription)
        }
    }
}
    func fetchTeams(completion : @escaping ([Team]?, String?) -> Void) {
        let request = AF.request(teamsURL , method: .get, headers: headers)
        request.responseDecodable(of:Teams.self) { response in
            switch response.result {
            case .success(let response):
                completion(response.teams, nil)
            case .failure(let error) :
                completion(nil, error.errorDescription)
            }
        }
    }
}


