

import Foundation
import SQLite


class CompetitionsViewModel{
    
    let apiService = APIService.shared
    var competitions : [Competition] = []
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    
    
    func getcompetitions(){
        let competitionsFromDB = DBManager.shared.fetchCompetitionsFromDatabase()
        if !competitionsFromDB.isEmpty {
            self.competitions = competitionsFromDB
            self.successClouser?()
        }else{
            apiService.fetchCompetitions { competitions, error in
                if let error = error {
                    //fire error closure
                    self.errorClouser?(error)
                }else{
                    //save competitions locale
                    DBManager.shared.deleteAllCompetitions()
                    DBManager.shared.saveToDatabase(competitions: competitions ?? [])
                    self.competitions = competitions ?? []
                    // fire sucess closure
                    self.successClouser?()
                }
            }
        }
    }
}


