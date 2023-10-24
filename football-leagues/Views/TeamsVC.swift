

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class TeamsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let teamsVM = TeamsVM()
    var selectedCompetitionId : Int?
    var teams : [Team] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Teams"
        let fontSize : CGFloat = 24.0
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:fontSize)]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let tableViewInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.contentInset = tableViewInsets
        tableView.register(UINib.init(nibName: "CompetitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionsCell")
        
        tableView.register(UINib.init(nibName: "TeamsCell", bundle: nil), forCellReuseIdentifier: "TeamsCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        teamsVM.successClouser = {
            self.tableView.reloadData()
        }
        teamsVM.errorClouser = { error in
            self.showError(error)
        }
       // competitionsVM.getcompetitions()
        if let selectedCompetitionId = selectedCompetitionId {
            teamsVM.getTeams(competitionId: selectedCompetitionId)
        }
    }
    
    // create error alert
    func showError(_ errorMessage : String){
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDataSource
extension TeamsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return teamsVM.teams.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionsCell", for: indexPath) as! CompetitionsTableViewCell
            if let selectedCompetition = teamsVM.competitionObj {
                
                if let competitionImage = URL(string: selectedCompetition.emblem ?? "Empty_URL_string"){
                    let svgCoder = SDImageSVGCoder.shared
                    SDImageCodersManager.shared.addCoder(svgCoder)
                    cell.competitionImage.sd_setImage(with: competitionImage, placeholderImage: UIImage(named: "Copa"))
                }
                if let competitionName = selectedCompetition.name{
                    cell.competitionNameLabel.text = competitionName
                }
                if let areaFlagImage = URL(string: selectedCompetition.area?.flag ?? "Empty_URL_string"){
                    let svgCoder = SDImageSVGCoder.shared
                    SDImageCodersManager.shared.addCoder(svgCoder)
                    cell.areaFlagImage.sd_setImage(with: areaFlagImage, placeholderImage: UIImage(named: "copa_flag"))
                }
                if let areaName = selectedCompetition.area?.name{
                    cell.areaName.text = areaName
                }
            }
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
            let teams = teamsVM.teams[indexPath.row]
            if let teamName = teams.name {
                cell.teamNameLabel.text = teamName
            }
            if let teamImage = URL(string : teams.crest ?? "cant load image") {
                let svgCoder = SDImageSVGCoder.shared
                SDImageCodersManager.shared.addCoder(svgCoder)
                cell.teamImage.sd_setImage(with: teamImage, placeholderImage: UIImage(named: "placeholder"))
            }
            return cell
        }
    }
}
// MARK: - UITableViewDelegate
extension TeamsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to Games screen
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return ""
            } else if section == 1 {
                return "Teams"
            }
            return nil
        }
}
