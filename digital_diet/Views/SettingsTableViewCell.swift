//
//  SettingsTableViewCell.swift
//  digital_diet
//
 
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var buttonTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
            buttonTappedHandler?()
        }

}
