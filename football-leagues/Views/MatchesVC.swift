
import UIKit

class MatchesVC: UIViewController {
    var selectedTeamId : Int?
    @IBOutlet weak var matchesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Matches"
        let fontSize : CGFloat = 24.0
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:fontSize)]
        navigationController?.navigationBar.titleTextAttributes = attributes

       
    }

}
