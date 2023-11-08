
import Foundation

class TeamsVM {
    let apiService = APIService.shared
    var teams : [Team] = []
    var competitionObj: Competition?
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    var errorMsg: String?
    var stateClouser : ((State) -> ())?
    var state : State? {
        didSet {
            self.stateClouser?(state!)
        }
    }
    func getTeams(competitionId: Int) {
        self.state = .loading
        apiService.fetchTeams(competitionId: competitionId) { response, error in
            if let error = error {
                self.errorMsg = error
                self.state = .error
            }else{
                self.competitionObj = response?.competition
                self.teams = response?.teams ?? []
                self.state = .success
            }
        }
    }
    
    
}
