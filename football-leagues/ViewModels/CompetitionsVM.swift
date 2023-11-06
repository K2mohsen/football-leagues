

import Foundation
import SQLite


class CompetitionsViewModel{
    
    let apiService = APIService.shared
    var competitions : [Competition] = []
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    var stateClouser : ((State) -> ())?
    var state : State? {
        didSet {
            self.stateClouser?(state!)
        }
    }
    func getcompetitions(){
        self.state = .loading

        let competitionsFromDB = DBManager.shared.fetchCompetitionsFromDatabase()
        
        if !competitionsFromDB.isEmpty {
            self.competitions = competitionsFromDB
            self.state = .success
        }else{
            apiService.fetchCompetitions { competitions, error in
                if let error = error {
                    self.state = .error
                    print(error)
                }else{
                    //save competitions locale
                    if let competitions = competitions, !competitions.isEmpty {
                        DBManager.shared.deleteAllCompetitions()
                        DBManager.shared.saveToDatabase(competitions: competitions)
                        self.competitions = competitions
                        self.state = .success
                    }else {
                        self.state = .empty
                    }
                    
                }
            }
        }
    }
}


