//
//  RepoTableViewCell.swift
//  RepoSite
//
//  Created by user176911 on 7/3/21.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
