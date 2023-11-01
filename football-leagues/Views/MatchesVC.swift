
import UIKit
import SDWebImageSVGCoder


class MatchesVC: UIViewController {
    
    @IBOutlet weak var matchesTable: UITableView!
    var selectedTeamId : Int?
    private let matchesVM = MatchesVM()
    var matches : [Match] = []
    var selectedTeam: Team?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Matches"
        let fontSize : CGFloat = 24.0
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:fontSize)]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let tableViewInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        matchesTable.contentInset = tableViewInsets
        
        matchesTable.register(UINib.init(nibName: "TeamsCell", bundle: nil), forCellReuseIdentifier: "TeamsCell")
        matchesTable.register(UINib.init(nibName: "MatchesCell", bundle: nil), forCellReuseIdentifier: "MatchesCell")
        
        matchesTable.dataSource = self
        
        matchesVM.successClouser = {
            self.matchesTable.reloadData()
        }
        matchesVM.errorClouser = { error in
            self.showError(error)
        }
        if let selectedTeamId = selectedTeamId {
            matchesVM.getMatches(teamId: selectedTeamId)
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
//MARK: - DataSource
extension MatchesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return matchesVM.matches.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = matchesTable.dequeueReusableCell(withIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
            if let teamName = selectedTeam?.name {
                cell.teamNameLabel.text = teamName
            }
            if let teamImage = URL(string : selectedTeam?.crest ?? "cant load image") {
                let svgCoder = SDImageSVGCoder.shared
                SDImageCodersManager.shared.addCoder(svgCoder)
                cell.teamImage.sd_setImage(with: teamImage, placeholderImage: UIImage(named: "placeholder"))
            }
             
            return cell
        }else {
            let cell = matchesTable.dequeueReusableCell(withIdentifier: "MatchesCell", for: indexPath) as! MatchesCell
            let matches = matchesVM.matches[indexPath.row]
            
            if let homeTeamImage = URL(string: matches.homeTeam?.crest ?? "cant load image") {
                let svgCoder = SDImageSVGCoder.shared
                SDImageCodersManager.shared.addCoder(svgCoder)
                cell.homeTeamImage.sd_setImage(with: homeTeamImage, placeholderImage: UIImage(named: "placeholder"))
            }
            if let awayTeamImage = URL(string: matches.awayTeam?.crest ?? "cant load image") {
                let svgCoder = SDImageSVGCoder.shared
                SDImageCodersManager.shared.addCoder(svgCoder)
                cell.awayTeamImage.sd_setImage(with: awayTeamImage, placeholderImage: UIImage(named: "placeholder"))
            }
            if let matchStatus = matches.status {
                switch matchStatus {
                case .finished :
                    if let fullTime = matches.score?.fullTime{
                      let homeScore = fullTime.home ?? 0
                      let awayScore = fullTime.away ?? 0
                      let score = "\(homeScore) : \(awayScore)"
                      cell.scoreLabel.text = score
                      cell.statusLabel.text = "Finished"
                      let matchDate = matches.utcDate?.updateDateFormate(from: "yyyy-MM-dd'T'HH:mm:ssZZZ", to: "yyyy-MM-dd HH:mm")
                      cell.matchDateLabel.text = matchDate
                  }
                    
                case .scheduled :
                    cell.statusLabel.text = "scheduled"
                    cell.matchDateLabel.text = ""
                    let matchDate = matches.utcDate?.updateDateFormate(from: "yyyy-MM-dd'T'HH:mm:ssZZZ", to: "yyyy-MM-dd HH:mm")
                    cell.scoreLabel.text = matchDate
                case .timed:
                    let matchDate = matches.utcDate?.updateDateFormate(from: "yyyy-MM-dd'T'HH:mm:ssZZZ", to: "yyyy-MM-dd HH:mm")
                    cell.statusLabel.text = "timed"
                    cell.matchDateLabel.text = ""
                    cell.scoreLabel.text = matchDate
                case .postponed:
                    let matchDate = matches.utcDate?.updateDateFormate(from: "yyyy-MM-dd'T'HH:mm:ssZZZ", to: "yyyy-MM-dd HH:mm")
                    cell.statusLabel.text = "timed"
                    cell.matchDateLabel.text = ""
                    cell.scoreLabel.text = matchDate
                }
                
            }
              
            return cell
        }
    }
}
extension MatchesVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return ""
            } else if section == 1 {
                return "Matches"
            }
            return nil
        }
}
extension String {
    func updateDateFormate(from currentFormate : String,to newFormate : String) -> String {
        var formatedDate = ""
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = currentFormate
        
        if let date = dateFormater.date(from: self) {
            dateFormater.dateFormat = newFormate
            formatedDate = dateFormater.string(from: date)
        }
        
        return formatedDate
    }
}




            
