//
//  CustomMemoTableViewCell.swift
//  RealmPractice
//
//  Created by TakaoAtsushi on 2018/11/02.
//  Copyright © 2018 TakaoAtsushi. All rights reserved.
//

import UIKit

class CustomMemoTableViewCell: UITableViewCell {

    @IBOutlet  var memoImageView: UIImageView!
    @IBOutlet  var titleLabel: UILabel!
    @IBOutlet  var detailTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
