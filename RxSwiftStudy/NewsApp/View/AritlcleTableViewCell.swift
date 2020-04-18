//
//  AritlcleTableViewCell.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/18.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit

class AritlcleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
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
