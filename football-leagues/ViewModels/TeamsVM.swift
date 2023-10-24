
import Foundation

class TeamsVM {
    let apiService = APIService.shared
    var teams : [Team] = []
    var competitionObj: Competition?
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    func getTeams(competitionId: Int) {
        apiService.fetchTeams(competitionId: competitionId) { response, error in
            if let error = error {
                self.errorClouser?(error)
            }else{
                self.competitionObj = response?.competition
                self.teams = response?.teams ?? []
                self.successClouser?()
            }
        }
    }
    
    
}
