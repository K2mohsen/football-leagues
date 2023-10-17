
import Foundation
import Alamofire


class APIService{
    // singletone property
    static let shared = APIService()
    // private initializer
    private init () {}
    
    func fetchCompetitions(completion: @escaping ([Competition]?, String?) -> Void) {
        let baseURL = "https://api.football-data.org/v4/competitions"
        let apiKey = "7e21461aac484b229189d31e2abad0f1"
        let url = baseURL
        let headers : HTTPHeaders = [
            "X-Auth-Token": apiKey
        ]
        let request = AF.request(url, method: .get, headers: headers)
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
}


