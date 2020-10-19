//
//  WeightTermCell.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/18/20.
//

import UIKit

class WeightTermCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var weightDifferenceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
