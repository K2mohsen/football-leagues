
import UIKit

class CompetitionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var competitionImage: UIImageView!
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var areaFlagImage: UIImageView!
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var competitionTypeImage: UIImageView!
    @IBOutlet weak var competionTypeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
