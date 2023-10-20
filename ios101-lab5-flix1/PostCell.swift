//
//  PostCell.swift
//  ios101-lab5-flix1
//
//  Created by Yasaman Emami on 10/20/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var summaryText: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
