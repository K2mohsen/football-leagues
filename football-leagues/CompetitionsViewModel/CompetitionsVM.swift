//
//  CompetitionsVM.swift
//  football-leagues
//
//  Created by Innovitics on 10/10/2023.
//

import Foundation


class CompetitionsViewModel{
    
    let apiService = APIService.shared
    var competitions : [Competition] = []
    
    func getcompetitions(completion : @escaping () -> Void ){
        apiService.fetchCompetitions { competitions in
            if let competitions = competitions {
                self.competitions = competitions
            }
            completion()
        }
    }
}
