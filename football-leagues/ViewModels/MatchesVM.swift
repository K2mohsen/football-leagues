

import Foundation


class MatchesVM {
    let apiService = APIService.shared
    var matches : [Match] = []
    var errorMsg: String?
    var stateClouser : ((State) -> ())?
    var state : State? {
        didSet {
            self.stateClouser?(state!)
        }
    }
    func getMatches(teamId: Int) {
        self.state = .loading
        apiService.fetchMatches(teamId: teamId) { response, error in
            if let error = error {
                self.errorMsg = error
                self.state = .error
            }else{
                self.matches = response?.matches ?? []
                self.state = .success
            }
        }
    }
    
    
}
