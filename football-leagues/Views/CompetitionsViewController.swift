
import UIKit
import SDWebImage
import SDWebImageSVGCoder
import SQLite
import Shimmer


class CompetitionsViewController: UIViewController {
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let competitionsVM = CompetitionsViewModel()
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = tableView.center
        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        
        emptyStateView.isHidden = true
        
        self.title = "Competitions"
        let fontSize : CGFloat = 24.0
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:fontSize)]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let tableViewInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.contentInset = tableViewInsets
        tableView.register(UINib.init(nibName: "CompetitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionsCell")
        
        
        tableView.delegate = self
        tableView.dataSource = self

        competitionsVM.stateClouser = { State in
            switch State {
            case .success :
                self.tableView.reloadData()
                self.hideEmptyState()
                self.loadingIndicator.stopAnimating()
            case .error :
                self.showError(self.competitionsVM.errorMsg ?? "")
                self.loadingIndicator.stopAnimating()
            case .loading :
                self.loadingIndicator.startAnimating()
                print("is loading")
            case .empty :
                self.showEmptyState()
                self.loadingIndicator.stopAnimating()
            }
        }
        
        competitionsVM.getcompetitions()
    }
    func showError(_ errorMessage : String) {
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showEmptyState () {
        emptyStateView.isHidden = false
    }
    
    func hideEmptyState () {
        emptyStateView.isHidden = true
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
        
        if let competitionImage = URL(string: competition.emblem ?? "Empty_URL_string"){
            let svgCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            cell.competitionImage.sd_setImage(with: competitionImage, placeholderImage: UIImage(named: "Copa"))
        }
        if let competitionName = competition.name{
            cell.competitionNameLabel.text = competitionName
        }
        if let areaFlagImage = URL(string: competition.area?.flag ?? "Empty_URL_string"){
            let svgCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            cell.areaFlagImage.sd_setImage(with: areaFlagImage, placeholderImage: UIImage(named: "copa_flag"))
        }
        if let areaName = competition.area?.name{
            cell.areaName.text = areaName
        }
        if competition.type != nil{
            cell.competitionTypeImage.image = UIImage(named: "cup_image")
            cell.competionTypeName.text = "cup"
            cell.competitionTypeImage.image = UIImage(named: "league_image")
            cell.competionTypeName.text = "League"
            
        }
        return cell
    }
}
//MARK: - tableViewDelegate
extension CompetitionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCompetitionId = competitionsVM.competitions[indexPath.row].id
        let teamsVC = TeamsVC()
        teamsVC.selectedCompetitionId = selectedCompetitionId
        navigationController?.pushViewController(teamsVC, animated: true)
    }
}

