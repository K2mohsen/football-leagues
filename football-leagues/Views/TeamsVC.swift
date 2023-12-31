

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class TeamsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let teamsVM = TeamsVM()
    var selectedCompetitionId : Int?
    var teams : [Team] = []
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = tableView.center
        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        
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
        
         teamsVM.stateClouser = { State in
            switch State {
            case .success :
                self.tableView.reloadData()
                self.loadingIndicator.stopAnimating()
            case .error :
                self.showError(self.teamsVM.errorMsg ?? "")
                self.loadingIndicator.stopAnimating()
            case .loading :
                self.loadingIndicator.startAnimating()
                print("is loading")
            case .empty :
                self.loadingIndicator.stopAnimating()
            }
        }
        
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
                if let areaFlagImage = URL(string: selectedCompetition.emblem ?? "Empty_URL_string"){
                    let svgCoder = SDImageSVGCoder.shared
                    SDImageCodersManager.shared.addCoder(svgCoder)
                    cell.areaFlagImage.sd_setImage(with: areaFlagImage, placeholderImage: UIImage(named: "copa_flag"))
                }
                if let compCode = selectedCompetition.code{
                    cell.areaName.text = compCode
                }
                if selectedCompetition.type != nil{
                        cell.competitionTypeImage.image = UIImage(named: "cup_image")
                        cell.competionTypeName.text = "cup"
                        cell.competitionTypeImage.image = UIImage(named: "league_image")
                        cell.competionTypeName.text = "League"
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
        let selectedTeamId = teamsVM.teams[indexPath.row].id
        let matchesVC = MatchesVC()
        matchesVC.selectedTeam = teamsVM.teams[indexPath.row]
        matchesVC.selectedTeamId = selectedTeamId
        navigationController?.pushViewController(matchesVC, animated: true)
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
