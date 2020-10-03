//
//  ItemDetailViewController.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

     //MARK:-----Outlets---------
    @IBOutlet weak var itemName:UILabel!
    @IBOutlet weak var itemImage:UIImageView!
    @IBOutlet weak var itemDescription:UILabel!
    
     //MARK:-----Global Variables---------
    var item:Items?
    var updateTableView:(()->())?
    
     //MARK:---------View Methods----------
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item{
            itemName.text = item.name ?? "NA"
            itemDescription.text = item.itemDescription ?? "NA"
            if let image = item.image{
                itemImage.image = UIImage(named: image)
            }
        }
        // Do any additional setup after loading the view.
    }
    
     //MARK:---------Button Actions----------
    @IBAction func popScreen(_ sender:UIButton) {
       updateTableView?()
        self.navigationController?.popViewController(animated: true)
    }
    

}
