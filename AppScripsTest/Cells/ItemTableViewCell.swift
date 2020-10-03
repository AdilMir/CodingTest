//
//  ItemTableViewCell.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView:UIImageView!
    @IBOutlet weak var itemName:UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     //MARK:---------View Methods----------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(item:Items){
        if let image = item.image{
           itemImageView.image = UIImage(named: image)
        }
        item.isSelected ? (blurView.isHidden = false) : (blurView.isHidden = true)
        itemName.text = item.name ?? "Name Not Available"
       
    }

}
