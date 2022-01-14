//
//  CustomCell.swift
//  BooksApp
//
//  Created by Sameera Madushan on 2022-01-13.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var dis: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
