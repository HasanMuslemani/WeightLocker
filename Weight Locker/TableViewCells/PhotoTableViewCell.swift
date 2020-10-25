//
//  PhotoTableViewCell.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 10/24/20.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
