

import Foundation
import SQLite


class CompetitionsViewModel{
    
    let apiService = APIService.shared
    let competitionsFromDB = DBManager.shared.fetchCompetitionsFromDatabase()
    var competitions : [Competition] = []
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    
    
    func getcompetitions(){
        if !competitionsFromDB.isEmpty {
            self.competitions = competitionsFromDB
            self.successClouser?()
        }else{
            apiService.fetchCompetitions { competitions, error in
                if let error = error {
                    //fire error closure
                    self.errorClouser?(error)
                }else{
                    self.competitions = competitions ?? []
                    // fire sucess closure
                    self.successClouser?()
                }
            }
        }
       
    }
}


