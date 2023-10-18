
import Foundation

class TeamsVM {
    let apiService = APIService.shared
    var teams : [Team]? = []
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    func getTeams() {
        apiService.fetchTeams { teams, error in
            if let error = error {
                self.errorClouser?(error)
            }else{
                self.teams = teams ?? []
                self.successClouser?()
            }
        }
    }
    
    
}
