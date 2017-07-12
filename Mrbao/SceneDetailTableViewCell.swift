//
//  SceneDetailTableViewCell.swift
//  Mrbao
//
//  Created by jinpeng on 2017/6/15.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit

class SceneDetailTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
