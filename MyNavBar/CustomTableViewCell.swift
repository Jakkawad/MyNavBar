//
//  CustomTableViewCell.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/16/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import APAvatarImageView

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var mTitleLabel:UILabel!
    @IBOutlet weak var mSubtitileLabel:UILabel!
    @IBOutlet weak var mAvatarImage:APAvatarImageView!
    @IBOutlet weak var mThumbnailImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mAvatarImage.borderWidth = 0
        //self.mAvatarImage.borderColor = UIColor(hexString: "######").
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
