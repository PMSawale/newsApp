//
//  HeadLinesTableViewCell.swift
//  newsApp
//
//  Created by Pankaj Sawale on 03/09/23.
//

import UIKit

class HeadLinesTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImg.image = nil
    }
    
}
