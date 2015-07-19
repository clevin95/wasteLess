//
//  FieldTableViewCell.swift
//  WasteLess
//
//  Created by Carter Levin on 18/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell {
  let textField:UITextField = UITextField()
  override func awakeFromNib() {
    super.awakeFromNib()
    self.addSubview(textField)
    // Initialization code
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier:reuseIdentifier)
    self.addSubview(textField)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addSubview(textField)
  }
  
  override func layoutSubviews() {
    self.textField.frame = self.bounds
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
