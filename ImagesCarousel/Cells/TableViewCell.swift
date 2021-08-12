//
//  TableViewCell.swift
//  ImagesCarousel
//
//  Created by YeshwantSatya on 11/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelRef: UILabel!
    @IBOutlet weak var imgRef: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
