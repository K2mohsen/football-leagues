
import UIKit
import SDWebImage
import SDWebImageSVGCoder


class CompetitionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
     private let competitionsVM = CompetitionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.contentInset = tableViewInsets
        tableView.register(UINib.init(nibName: "CompetitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionsCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        competitionsVM.successClouser = {
            self.tableView.reloadData()
        }
        
        competitionsVM.errorClouser = { error in
            self.showError(error)
        }
        competitionsVM.getcompetitions()
    }
    // create error alert
    func showError(_ errorMessage : String){
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
//MARK: - tableViewDataSource
extension CompetitionsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        competitionsVM.competitions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionsCell", for: indexPath) as! CompetitionsTableViewCell
        let competition = competitionsVM.competitions[indexPath.row]
        
        if let competitionImage = URL(string: competition.emblem ?? "Empty URL string"){
            let svgCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            cell.competitionImage.sd_setImage(with: competitionImage, placeholderImage: UIImage(named: "Copa"))
        }
        if let competitionName = competition.name{
            cell.competitionNameLabel.text = competitionName
        }
        if let areaFlagImage = URL(string: competition.area?.flag ?? "Empty URL string"){
            let svgCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            cell.areaFlagImage.sd_setImage(with: areaFlagImage, placeholderImage: UIImage(named: "copa_flag"))
        }
        if let areaName = competition.area?.name{
            cell.areaName.text = areaName
        }
        if let compType = competition.type{
            switch compType {
            case .cup:
                cell.competitionTypeImage.image = UIImage(named: "cup_image")
                cell.competionTypeName.text = "cup"
            case .league:
                cell.competitionTypeImage.image = UIImage(named: "league_image")
                cell.competionTypeName.text = "League"
            }
        }
        return cell
    }
}
//MARK: - tableViewDelegate
extension CompetitionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let competitionId = competitionsVM.competitions[indexPath.row].id
    }
    
    
}

