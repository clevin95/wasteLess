//
//  PostInfoTableViewCell.swift
//  WasteLess
//
//  Created by Carter Levin on 19/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit

class PostInfoTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
