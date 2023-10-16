
import Foundation
import Alamofire


class APIService{
    // singletone property
    static let shared = APIService()
    // private initializer
    private init () {}
    
    func fetchCompetitions(completion: @escaping ([Competition]?, String?) -> Void) {
        let url = "http://api.football-data.org/v4/competitions"
        let request = AF.request(url)
        request.responseDecodable(of: [Competition].self) { response in
            switch response.result {
            case .success(let competitions):
                completion(competitions, nil)
            case .failure(let error) :
               // print("error fetching data :\(error)")
                completion(nil, error.errorDescription)
            }
        }
            
    }
        
}


