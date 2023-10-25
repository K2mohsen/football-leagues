

import Foundation


class MatchesVM {
    let apiService = APIService.shared
    var matches : [Match] = []
    var hometeamObj : Teams?
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    func getMatches(teamId: Int) {
        apiService.fetchMatches(teamId: teamId) { response, error in
            if let error = error {
                self.errorClouser?(error)
            }else{
                self.matches = response?.matches ?? []
                self.successClouser?()
            }
        }
    }
    
    
}
