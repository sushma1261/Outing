//
//  DelayCustomCell.swift
//  Outing
//
//  Created by SVECW-4 on 30/12/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit

class DelayCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var reasonL: UILabel!
    
    @IBOutlet weak var permitL: UILabel!
    
    @IBOutlet weak var delayL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
