//
//  BannerCollectionViewCell.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var bannerImageView:UIImageView!
    
    func setUpCell(image:UIImage){
        bannerImageView.image = image
    }
}
