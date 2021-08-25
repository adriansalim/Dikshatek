//
//  EtcTypeTableViewCell.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit

class EtcTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var valueCell: UILabel!
    @IBOutlet weak var staticCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
