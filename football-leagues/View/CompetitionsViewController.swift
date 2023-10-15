
import UIKit

class CompetitionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
     private let competitionsVM = CompetitionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "competitionsCell", bundle: nil), forCellReuseIdentifier: "competitionsCell")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitionsCell", for: indexPath) as! CompetitionsTableViewCell
        let competition = competitionsVM.competitions[indexPath.row]
        return cell
    }
}
//MARK: - tableViewDelegate
extension CompetitionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let competitionId = competitionsVM.competitions[indexPath.row].id
    }
    
    
}

