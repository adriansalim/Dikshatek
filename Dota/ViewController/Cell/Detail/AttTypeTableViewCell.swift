//
//  AttTypeTableViewCell.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit

class AttTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
