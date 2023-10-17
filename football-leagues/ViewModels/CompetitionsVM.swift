

import Foundation


class CompetitionsViewModel{
    
    let apiService = APIService.shared
    var competitions : [Competition] = []
    var successClouser: (() -> ())?
    var errorClouser: ((String) -> ())?
    func getcompetitions(){
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
