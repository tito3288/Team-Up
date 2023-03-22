//
//  SportCell.swift
//  Team Up
//
//  Created by Bryan Arambula on 1/8/22.
//

import UIKit

class SportCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.clipsToBounds = true
        messageBubble.layer.masksToBounds =  false
        messageBubble.backgroundColor = UIColor.black
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 2
        messageBubble.layer.shadowColor = UIColor.white.cgColor
        messageBubble.layer.shadowRadius = 10
        messageBubble.layer.shadowOpacity = 10
        messageBubble.layer.shadowOffset = CGSize(width: 0, height: 0)
        sportLabel.layer.shadowColor = UIColor.white.cgColor
        sportLabel.layer.shadowRadius = 10
        sportLabel.layer.shadowOpacity = 10
        sportLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
    
    
    @IBOutlet weak var messageBubble:UIView!
    @IBOutlet weak var sportLabel:UILabel!
    
    
    
    
}



