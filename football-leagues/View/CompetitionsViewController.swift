//
//  CompetitionsViewController.swift
//  football-leagues
//
//  Created by Innovitics on 01/10/2023.
//

import UIKit

class CompetitionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
     private let competitionsVM = CompetitionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        competitionsVM.successClouser = {
            // relode data 
        }
        
        competitionsVM.errorClouser = { error in
        }
    }
}

